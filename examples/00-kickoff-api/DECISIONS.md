# DECISIONS.md

## ADR-001: Use FastAPI with PostgreSQL

| Option | Pros | Cons | Complexity/Cost |
| --- | --- | --- | --- |
| FastAPI + Postgres | strong validation, good async support, familiar Python ecosystem | async patterns require discipline | medium |
| Node + Fastify | fast runtime, strong plugin ecosystem | less internal expertise | medium |
| Go + Fiber | high performance | slower team velocity | high |

- Decision: FastAPI with PostgreSQL on 2026-03-12.
- Why this choice:
  - Pydantic gives strong request validation out of the box.
  - Python ecosystem fits carrier integrations and worker tasks.
  - Postgres handles relational partner and shipment data cleanly.
- When to reconsider:
  - If throughput targets move well beyond current partner scale.

## ADR-002: Require idempotency keys on shipment creation

| Option | Pros | Cons | Complexity/Cost |
| --- | --- | --- | --- |
| Required idempotency key | safe retries, clear client contract | extra client work | low |
| Best-effort duplicate detection | less client friction | false positives and misses | medium |
| No idempotency | simplest | unsafe under network retries | low |

- Decision: Require `Idempotency-Key` on `POST /shipments`.
- Why this choice:
  - Prevents duplicate shipments on timeout retries.
  - Gives deterministic client behavior.
  - Easy to document and test.
- When to reconsider:
  - If all creation traffic moves to async ingestion with upstream deduplication.

## Summary

| ADR | Choice |
| --- | --- |
| 001 | FastAPI + PostgreSQL |
| 002 | Required idempotency keys for creates |

Prefer predictable partner contracts over hidden server-side guesses.
