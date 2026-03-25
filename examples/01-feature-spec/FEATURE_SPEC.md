# FEATURE_SPEC.md

## Feature Overview

Add saved search alerts to an existing apartment rental app so signed-in renters can be emailed when new listings match their search filters.

## User Flows

1. User runs a search, clicks `Save search`, names the alert, and confirms email frequency.
2. System stores the saved filter set and shows a success banner in the search page.
3. When a new listing matches, the nightly matcher queues an email digest.
4. User opens the digest, clicks through to matching listings, or disables the alert from account settings.

## UI & Components

| Surface | Details |
| --- | --- |
| search results page | adds `Save search` button beside filter summary for signed-in users |
| save-search modal | fields: alert name, frequency select, email preview copy, confirm button |
| account alerts page | table of saved alerts with edit, pause, delete actions |
| digest email | alert name, up to 10 new listings, CTA to search results |

## API Changes

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/api/search-alerts` | create saved alert |
| `PATCH` | `/api/search-alerts/:id` | rename, pause, change frequency |
| `DELETE` | `/api/search-alerts/:id` | delete alert |

## Data Changes

| Table | Fields |
| --- | --- |
| `search_alerts` | `id uuid pk`, `user_id uuid fk`, `name text`, `filters jsonb`, `frequency text`, `status text`, `last_sent_at timestamptz`, `created_at timestamptz` |

Index `search_alerts(user_id, status)` and GIN index on `filters`.
No backfill is required because alerts live in a new table. Existing search URLs remain compatible because `filters` reuse the app's current search query serialization format.

## Permissions & Access Control

Only authenticated renters can create alerts. Users may only manage their own alerts. Admins can view alerts for support purposes through an internal dashboard, but cannot edit user filters.

## Edge Cases & Error Handling

- Duplicate alert name for the same user returns inline validation.
- Saving a search with zero active filters is blocked with helper text.
- If email delivery fails, keep the alert active and retry in the next batch while logging the failure.
- If a listing is removed before the digest sends, exclude it from the email.

## Existing Flow Impact

Search results now contain a signed-in only CTA and an extra empty state for users with no alerts. Account settings gains a new `Saved alerts` section. Nightly listing publication jobs now also trigger the matcher pipeline.

## Regression Risks

Highest-risk areas are search filter serialization, nightly listing jobs, and account settings navigation. Add regression coverage for existing search URLs, job runtime, and account settings rendering so the feature does not break search or onboarding flows.

## Third-Party Services

Resend sends the digests. If Resend is down, queue the digest for the next scheduled run and emit an alert if failures exceed 5% of attempts in one hour.

## Feature Flag

Wrap the UI and jobs with `saved_search_alerts`. Disabled state hides the save CTA and skips matcher jobs.

## Rollout & Rollback

Enable for internal staff first, then 10% of signed-in renters, then 100% after 72 hours without delivery or performance regressions. Roll back by disabling the feature flag, pausing matcher jobs, and draining queued digests.

## Testing

Unit test filter serialization and digest deduplication. Integration test create, edit, delete, and ownership enforcement. E2E test saving an alert from search results and managing it from account settings. Add regression tests for existing search URL parsing.

## Observability

Log alert creation, digest enqueue, digest send success, digest send failure, and matcher runtime. Track active alerts, digest send rate, click-through rate, and failure percentage. Alert if matcher runtime exceeds 15 minutes or delivery failures exceed 5%.

## Implementation Order

1. Add `search_alerts` table and indexes.
2. Add alert CRUD endpoints with ownership checks.
3. Add search results save flow and account settings management UI.
4. Add matcher job and digest email template.
5. Add feature flag, monitoring, and regression coverage.

## Open Questions

- Should hourly alerts be allowed in MVP, or only daily and weekly?
- Should users be able to save more than one alert with identical filters but different names?
