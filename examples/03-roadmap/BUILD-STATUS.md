# BUILD-STATUS.md

## Header

Update status in the same PR or commit as the work. Valid status values are `not started`, `in progress`, `blocked`, and `done`. If scope changes, update the source document and this tracker together. When a workstream reaches `done`, add a short note with the last meaningful milestone.

## Snapshot

| Field | Value |
| --- | --- |
| Last updated | 2026-03-25 |
| Current target phase | Phase 1 - City Pilot |
| Implementation repo path | `/Users/me/projects/blockparty` |
| Initial notes | Specs are drafted, but no production code has been merged yet. Prioritize the workstreams in the order listed below. |

## Done So Far

- `MVP_DOCUMENT.md`, `DECISIONS.md`, and `ROADMAP.md` drafted.
- Architecture choices for stack, search approach, and moderation model are recorded.
- No application code or infrastructure has been marked complete yet.

## Phase 1 Workstreams

### Browse and item detail

- Status: `not started`
- Source of truth: `MVP_DOCUMENT.md` -> `Pages & Features`, `Responsive Breakpoints`, `Error Handling`
- Left to build:
  - Create marketing and browse routes
  - Implement filters, pagination, and item detail fetches
  - Add empty, loading, and reservation conflict states
- Notes: Search query serialization must stay stable because later saved-search work will depend on it.

### Listing creation and media upload

- Status: `not started`
- Source of truth: `MVP_DOCUMENT.md` -> `Pages & Features`, `Data Architecture`, `Security`
- Left to build:
  - Create authenticated `/post` route and form validation
  - Add image upload flow with storage rules and MIME validation
  - Add draft autosave behavior for signed-in users
- Notes: Storage paths and validation rules must match the security expectations in the MVP doc.

### Reservation and owner notification flow

- Status: `not started`
- Source of truth: `MVP_DOCUMENT.md` -> `User Flows`, `Data Architecture`, `Error Handling`
- Left to build:
  - Create reservation mutation and uniqueness enforcement
  - Add owner email notification
  - Add post-reservation UI states for item owners and reservers
- Notes: Reservation conflicts are a release-critical edge case and need both integration and E2E coverage.

### Moderation queue and audit log

- Status: `not started`
- Source of truth: `MVP_DOCUMENT.md` -> `Admin Workflow`, `Permissions & Access Control`, `Pages & Features`
- Left to build:
  - Create admin review route and queue ordering
  - Implement approve, hide, and remove actions
  - Write moderation audit trail and owner notification behavior
- Notes: Moderator and admin permissions must be enforced on the server, not only in hidden navigation.

### Monitoring and release hardening

- Status: `not started`
- Source of truth: `MVP_DOCUMENT.md` -> `Testing Strategy`, `Environment Variables`, `Error Handling`; `ROADMAP.md` -> `Phase 1: City Pilot`
- Left to build:
  - Configure Sentry and request IDs
  - Add the first end-to-end flows to CI
  - Create staging sign-off checklist for posting, reserving, and moderation
- Notes: This workstream should begin once browse, posting, and moderation have working vertical slices.

## Phase 2 Workstreams

### Search quality and performance

- Status: `not started`
- Source of truth: `ROADMAP.md` -> `Phase 2: Public Launch`
- Left to build:
  - Optimize browse queries and caching strategy
  - Improve filter UX and result relevance defaults
  - Add performance monitoring for high-traffic routes
- Notes: Do not start until Phase 1 browse metrics reveal the main bottlenecks.

### Notification and re-engagement improvements

- Status: `not started`
- Source of truth: `ROADMAP.md` -> `Phase 2: Public Launch`
- Left to build:
  - Add owner reminders and clearer reservation follow-ups
  - Prototype saved filters or digest hooks
  - Define delivery failure handling for higher-volume email traffic
- Notes: Keep this aligned with any later saved-search feature spec rather than inventing behavior here.

### Moderation tooling improvements

- Status: `not started`
- Source of truth: `ROADMAP.md` -> `Phase 2: Public Launch`
- Left to build:
  - Add queue filters and reporter history improvements
  - Reduce clicks for common moderation actions
  - Add operational reporting for turnaround time
- Notes: Keep human review as the decision-maker in Phase 2.

## Phase 3 Workstreams

### City expansion support

- Status: `not started`
- Source of truth: `ROADMAP.md` -> `Phase 3: Trust and Growth`
- Left to build:
  - Add location onboarding and city configuration controls
  - Review whether seeding and support workflows need admin tooling
  - Ensure search and moderation settings can vary by city if required
- Notes: This workstream is blocked on the Phase 2 launch learning loop.

### Trust automation

- Status: `not started`
- Source of truth: `ROADMAP.md` -> `Phase 3: Trust and Growth`
- Left to build:
  - Add duplicate-report clustering
  - Add moderation prioritization rules
  - Measure false-positive and false-negative outcomes before turning on automation widely
- Notes: Use flags for any automated action that could hide content.

### Retention features

- Status: `not started`
- Source of truth: `ROADMAP.md` -> `Phase 3: Trust and Growth`
- Left to build:
  - Add saved searches and digest emails
  - Add lightweight reputation signals for repeat posters
  - Measure repeat visits and reservation completion after launch
- Notes: Coordinate with any dedicated feature specs before implementation starts.

## Open Blockers

None recorded yet.
