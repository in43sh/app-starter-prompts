# ROADMAP.md

## Phase Summary Table

| Phase | Name | Goal | Status |
| --- | --- | --- | --- |
| 1 | City Pilot | Launch the moderated BlockParty marketplace in one city and validate core posting, reservation, and review loops. | not started |
| 2 | Public Launch | Open the marketplace broadly, harden operations, and improve discovery and notification quality. | not started |
| 3 | Trust and Growth | Expand geography, automate trust workflows, and add retention features that increase repeat usage. | not started |

## Working Rules

- `MVP_DOCUMENT.md` is the source of truth for product requirements, UI behavior, schema, and endpoints.
- `DECISIONS.md` is the source of truth for architecture choices that should not be reopened without an explicit update.
- `ROADMAP.md` decides what belongs in each phase and what is intentionally deferred.
- `BUILD-STATUS.md` tracks implementation progress against the current roadmap. Update it in the same PR or commit as the work.
- If scope changes, update the source document first, then update this roadmap and the build tracker in the same change.

## Decision Log

- Use Next.js App Router and Supabase to keep the first launch operationally simple while still covering auth, storage, and server-side data access.
- Launch in one city first so moderation load, pickup behavior, and abuse patterns can be validated before geographic expansion.
- Use ZIP plus latitude/longitude radius search instead of advanced geospatial features for v1 because it is sufficient for local discovery and faster to implement.
- Allow only one active reservation per item to reduce owner coordination complexity and prevent ambiguous pickup states.
- Keep moderation human-in-the-loop for the first launch so trust and safety rules can be tuned before automation.

## Non-goals

- Native iOS or Android apps before the responsive web app and moderation workflow are stable.
- In-app chat in Phase 1; email and in-app status updates are enough for the pilot.
- Paid boosts, subscriptions, or any monetization work before marketplace behavior is healthy.
- Multi-city expansion before moderation turnaround time and reservation completion rates are acceptable in the first city.

## Phase 1: City Pilot

- Goal: Launch the full posting, browsing, reservation, and moderation loop for one city with manual trust and safety review.
- Scope:
  - Public browse and item detail pages
  - Authenticated posting flow with photo uploads
  - Reservation flow with owner notifications
  - Report flow and admin review queue
  - Basic analytics and error reporting
- Intentionally skipped:
  - Real-time chat, because reservation confirmation can run through email and in-app states
  - Multi-city onboarding, because moderation and supply quality need to be proven first
  - Referral loops, because activation and fulfillment are the first priorities
- Testing strategy:
  - Unit tests for validation, role checks, and moderation helpers
  - Integration tests for RLS, posting, reserving, and abuse reporting
  - E2E coverage for post, reserve, and moderator review flows
- Deployment notes:
  - Single Vercel production environment backed by one Supabase project
  - Seed moderation roles before launch
  - Sentry and transactional email must be configured before beta users are invited
- Success criteria:
  - Users can post, reserve, and report listings without staff intervention
  - Moderators can review every flagged item from one queue and produce an audit trail
  - No blocker bugs remain in posting, reservation, or moderation flows after staging sign-off
- Exit gate:
  - Staging sign-off completed for the core flows
  - Moderation turnaround time is consistently under 24 hours in the pilot
  - Launch checklist complete for auth, storage, monitoring, and support inboxes

## Phase 2: Public Launch

- Goal: Expand beyond the initial pilot audience and harden the marketplace for broader public traffic.
- Scope:
  - Performance improvements for browse and search
  - Better reservation notifications and owner reminders
  - Saved filters and re-engagement email hooks
  - Moderation tooling improvements for triage speed
- Intentionally skipped:
  - Full moderation automation, because enough labeled decisions are not available yet
  - Monetization, because growth quality matters more than revenue at this stage
- Testing strategy:
  - Load-test browse and detail endpoints
  - Regression test all Phase 1 flows before each production release
  - Shadow-test moderation queue changes on historical report data where possible
- Deployment notes:
  - Separate staging and production Supabase projects
  - Production releases move to scheduled deployment windows with rollback owner assigned
- Success criteria:
  - Public users can onboard without direct support help
  - Browse and detail performance remain acceptable under launch traffic
  - Notification delivery and moderation operations scale without manual spreadsheet tracking
- Exit gate:
  - Public launch runs for at least two weeks without a critical reliability issue
  - Support and moderation teams confirm current tooling is sufficient for daily volume

## Phase 3: Trust and Growth

- Goal: Improve retention, expand to more neighborhoods, and reduce manual moderation work without losing trust quality.
- Scope:
  - Additional city onboarding flow
  - Lightweight reputation signals for repeat posters
  - Moderation prioritization and duplicate-report clustering
  - Retention loops such as saved searches and digest emails
- Intentionally skipped:
  - Native mobile apps, unless mobile web usage proves the need
  - Complex reputation scores, because simple signals should be validated first
- Testing strategy:
  - A/B or holdback testing for retention features when possible
  - Regression coverage for moderation automation decisions
  - Operational review of false-positive and false-negative moderation outcomes
- Deployment notes:
  - Expansion only after support staffing and moderation coverage are confirmed
  - Release automation changes behind flags and staged rollout rules
- Success criteria:
  - New cities can be configured without one-off code changes
  - Retention features improve repeat visits without raising abuse rates
  - Moderation tooling reduces manual review time while preserving decision quality
- Exit gate:
  - City expansion checklist exists and has been used successfully at least once
  - Trust metrics remain within acceptable thresholds after automation changes

## Open Questions

- Should Phase 2 include saved searches, or should that wait until moderation tooling is more mature?
- What operational threshold should trigger adding moderation automation instead of more manual reviewers?
- Does city expansion require a separate supply seeding playbook before engineering work begins?
