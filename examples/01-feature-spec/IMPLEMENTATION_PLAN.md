# IMPLEMENTATION_PLAN.md

## Task 1: Add `search_alerts` table

- What it involves: Create the database table, indexes, and migration for storing saved filters and delivery metadata. No backfill is required because this is net-new data, but the stored filter payload must remain compatible with the app's current search query serialization.
- Files to create or modify: `db/migrations/*`, `db/schema.sql`
- Acceptance criteria: Migration applies cleanly and table supports CRUD for owned alerts.
- Regression considerations: Existing search and account queries still perform within current latency budget.
- Depends on: none

## Task 2: Build alert CRUD endpoints

- What it involves: Add create, update, and delete handlers plus request validation and ownership enforcement.
- Files to create or modify: `src/api/search-alerts.ts`, `src/lib/validation/searchAlerts.ts`
- Acceptance criteria: Authenticated users can manage only their own alerts and invalid filter payloads return `400`.
- Regression considerations: Existing auth middleware and account APIs keep current behavior.
- Depends on: Task 1

## Task 3: Add search results save flow

- What it involves: Add the `Save search` CTA, modal, and success/error states to the search results page.
- Files to create or modify: `src/pages/search.tsx`, `src/components/search/SaveSearchModal.tsx`
- Acceptance criteria: Signed-in users can save an alert from active filters and guests never see the CTA.
- Regression considerations: Existing search filters, result sorting, and pagination still work unchanged.
- Depends on: Task 2

## Task 4: Add account alerts management

- What it involves: Add a settings page section for listing, pausing, renaming, and deleting saved alerts.
- Files to create or modify: `src/pages/account/alerts.tsx`, `src/components/account/AlertTable.tsx`
- Acceptance criteria: Users can manage their alerts without leaving account settings.
- Regression considerations: Existing account settings tabs and profile actions still render correctly.
- Depends on: Task 2

## Task 5: Add matcher job and digest email

- What it involves: Build the nightly matcher, queue email sends, and add the HTML/text email template.
- Files to create or modify: `src/jobs/matchSearchAlerts.ts`, `src/emails/searchAlertDigest.tsx`
- Acceptance criteria: New listings enqueue digests for matching active alerts and failed sends are logged for retry.
- Regression considerations: Existing nightly listing jobs complete within their current runtime threshold.
- Depends on: Task 1

## Task 6: Add flag, metrics, and tests

- What it involves: Wire the feature flag, metrics, alerts, and automated coverage for the new flow and regressions.
- Files to create or modify: `src/lib/flags.ts`, `tests/search-alerts/*`
- Acceptance criteria: Feature can be disabled without code changes and regression suite covers search URL parsing plus alert ownership.
- Regression considerations: CI duration remains acceptable and existing test suites stay green.
- Depends on: Task 3, Task 4, Task 5

## Risk Table

| Task | Risk level | Mitigation |
| --- | --- | --- |
| Task 1 | low | keep schema narrow and indexed |
| Task 2 | medium | add ownership integration tests |
| Task 3 | medium | add E2E coverage for search state preservation |
| Task 4 | low | reuse existing account settings layout patterns |
| Task 5 | high | stage rollout behind a flag and add runtime alerts |
| Task 6 | medium | keep regression coverage focused on changed flows |
