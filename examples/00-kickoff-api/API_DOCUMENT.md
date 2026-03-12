# API_DOCUMENT.md

## Project Overview

Parcel Ping is a partner-facing API that lets ecommerce platforms register shipments and notify shoppers when package status changes. It uses FastAPI, PostgreSQL, Redis, and a worker queue for webhook fan-out.

| Area | Choice |
| --- | --- |
| Runtime | Python 3.13 |
| Framework | FastAPI |
| Database | PostgreSQL 16 |
| Queue | Redis + RQ |
| Hosting | Fly.io |

## API Design

REST JSON API under `/v1`. Clients send and receive `application/json`. Collection endpoints use cursor pagination with `limit` default `50` and max `200`. Filtering uses query params such as `carrier`, `status`, and `created_after`. Sorting is limited to documented fields with `sort=created_at` and `order=desc`. Breaking changes require a new versioned path; additive fields may be introduced without a version bump.

## Authentication & Authorization

Partner accounts authenticate with API keys sent in `Authorization: Bearer <key>`. Keys are created in the partner console and stored hashed in the database. All endpoints are partner-scoped; each request is authorized against the caller's `partner_id`.

## Endpoints

### `POST /v1/shipments`

Creates a shipment record and starts carrier polling.

| Field | Type | Notes |
| --- | --- | --- |
| `order_id` | string | partner order reference |
| `tracking_number` | string | required |
| `carrier` | string | `ups`, `usps`, `fedex`, `dhl` |
| `recipient_email` | string | optional |

Success response: `201` with `shipment_id`, `status`, `created_at`. Errors: `400` invalid payload, `409` duplicate tracking number for same partner. Idempotency: clients must send `Idempotency-Key`; duplicate keys within 24 hours return the original response body.

### `GET /v1/shipments`

Returns shipments for the authenticated partner. Supports `cursor`, `limit`, `carrier`, `status`, `created_after`, `sort`, and `order`.

### `POST /v1/webhooks/endpoints`

Registers a webhook destination. Requires HTTPS URL and HMAC secret name.

## Error Handling

All errors return:

```json
{
  "error": {
    "code": "shipment_conflict",
    "message": "Tracking number already exists for this partner.",
    "request_id": "req_123"
  }
}
```

Use `400` for validation, `401` for missing credentials, `403` for wrong partner scope, `404` for missing resources, `409` for conflicts, `429` for rate limits, and `502` for upstream carrier failures.

## Data Architecture

| Table | Fields |
| --- | --- |
| `partners` | `id uuid pk`, `name text`, `webhook_signing_secret text`, `created_at timestamptz` |
| `api_keys` | `id uuid pk`, `partner_id uuid fk`, `key_prefix text`, `key_hash text`, `last_used_at timestamptz` |
| `shipments` | `id uuid pk`, `partner_id uuid fk`, `order_id text`, `tracking_number text`, `carrier text`, `status text`, `latest_event_at timestamptz`, `created_at timestamptz` |
| `shipment_events` | `id uuid pk`, `shipment_id uuid fk`, `carrier_status text`, `normalized_status text`, `payload jsonb`, `occurred_at timestamptz` |
| `webhook_endpoints` | `id uuid pk`, `partner_id uuid fk`, `url text`, `status text`, `created_at timestamptz` |

Indexes: unique on `shipments(partner_id, tracking_number)`, btree on `shipments(partner_id, created_at desc)`, and btree on `shipment_events(shipment_id, occurred_at desc)`.

## Background Jobs / Events / Webhooks

`poll_carrier_status` runs every 30 minutes for in-transit shipments. `deliver_partner_webhook` retries with exponential backoff at 1, 5, 15, and 60 minutes, then marks the attempt failed. Outbound events include `shipment.created`, `shipment.in_transit`, `shipment.delivered`, and `shipment.exception`.

## Upstream Integrations

| Service | Purpose | Timeout | Retry | Failure behavior |
| --- | --- | --- | --- | --- |
| EasyPost | carrier tracking lookups | 3s connect, 8s total | 2 retries on 5xx and timeout | keep last known status, emit internal warning |
| Resend | shopper email delivery | 3s connect, 10s total | 1 retry on timeout | mark notification failed and continue |

Circuit breaker opens after 5 EasyPost failures in 2 minutes and pauses polling for 10 minutes.

## Rate Limiting

Default limit is 600 requests per minute per partner API key. Response headers include `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `Retry-After` when throttled.

## Security

Hash API keys with Argon2id, validate all input with Pydantic schemas, use parameterized SQL through SQLAlchemy, encrypt webhook secrets at rest, and sign outbound webhooks with HMAC-SHA256.

## Project Structure

```text
app/
  api/                  FastAPI routers
  core/                 settings, auth, logging
  db/                   models and session management
  services/             carrier clients and webhook delivery
  workers/              RQ job definitions
tests/
  integration/          API and DB tests
  unit/                 service and utility tests
docs/                   generated specs and ADRs
```

## Environment Variables

| Name | Secret | Purpose |
| --- | --- | --- |
| `DATABASE_URL` | yes | PostgreSQL connection |
| `REDIS_URL` | yes | queue backend |
| `EASYPOST_API_KEY` | yes | carrier data |
| `RESEND_API_KEY` | yes | email delivery |
| `APP_BASE_URL` | no | webhook links and docs |

## Testing Strategy

Write unit tests for idempotency key handling, webhook signing, and carrier status normalization. Write integration tests for shipment creation, duplicate conflicts, cursor pagination, and partner scoping. Add contract tests for webhook payloads.

## Implementation Order

1. Set up FastAPI app, settings, and database schema.
2. Implement partner auth and scoped request context.
3. Build shipment creation and listing endpoints with idempotency.
4. Add carrier polling jobs and event persistence.
5. Add webhook endpoint registration and delivery workers.
6. Add rate limiting, metrics, and contract tests.

## Success Metrics

P95 API latency under 250ms for read endpoints, webhook delivery success above 99%, carrier polling freshness under 45 minutes, and less than 0.5% duplicate shipment conflicts caused by client retries.
