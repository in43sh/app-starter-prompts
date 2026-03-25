# Roadmap & Build Status

I have a project spec and want to plan the phased rollout. Help me create a roadmap and a live build tracker precise enough to give an AI coding assistant full context at the start of any session — without a codebase audit or human explanation.

If I mention existing spec documents (such as `MVP_DOCUMENT.md`, `IMPLEMENTATION_PLAN.md`, or similar), read them before asking questions — derive workstreams, decisions, and scope from them directly rather than asking me to re-describe what is already written.

Ask me questions in stages — don't dump everything at once. Start with what already exists and what the first milestone is, then phases and scope, then exit gates and success criteria, then decisions already made. Wait for my answers before moving to the next stage.

If I do not know a materially important detail, help me choose by presenting a small set of sensible options and recommending one with brief reasoning. If an important detail remains unresolved, mark it as an open question rather than inventing it.

Output quality bar:

- Exit gates must be concrete and checkable — not vague phrases like "mostly done" or "stable enough."
- Every phase must have an explicit list of what is intentionally deferred and why.
- Decision log entries must capture the actual reason, not just the outcome.
- `BUILD-STATUS.md` workstreams must map directly to the spec — include source-of-truth pointers.

## Stage 1 — Current State

- What spec or planning documents already exist for this project?
- What has already been built, if anything?
- What is the immediate next milestone — staging, closed beta, or public launch?

## Stage 2 — Phases

- How many phases make sense? (e.g. MVP → pre-launch hardening → growth)
- What features or workstreams belong in Phase 1?
- What is explicitly deferred to Phase 2 or later? Be specific — what won't be built yet, and why?
- Are there any items that are intentionally never in scope?

## Stage 3 — Exit Gates & Success Criteria

- What does "Phase 1 is done" mean concretely? What must be true before Phase 2 starts?
- What does "ready for public launch" mean, if that is different from Phase 1 completion?

## Stage 4 — Decision Log

- What major product or architecture decisions have already been made and should not be re-litigated during implementation?
- Why was each decision made? (even a short reason is enough)
- What decisions are still open?

After I answer, produce the following two documents:

---

### 1. `ROADMAP.md`

A phased product roadmap. Include every section below:

- **Phase Summary Table** — a quick-reference table at the top: one row per phase with columns for Phase, Name, Goal (one sentence), and Status (`not started` initially)
- **Working Rules** — how this document relates to other spec docs (what is the source of truth for what), and how to keep them in sync when a rule changes
- **Decision Log** — major product and architecture decisions already made, one per bullet: what was decided and why. These must not be re-litigated during implementation.
- **Non-goals** — things explicitly out of scope for all phases, or explicitly deferred to a named future phase, with a brief reason for each
- **Phase N: [Name]** — one section per phase, each containing:
  - Goal (one sentence)
  - Scope — features and workstreams included in this phase
  - Intentionally skipped — what is deferred from this phase and why
  - Testing strategy — how this phase will be validated before exit
  - Deployment notes — hosting, environment, and release details relevant to this phase
  - Success criteria — concrete, checkable conditions that confirm the phase delivered what was expected
  - Exit gate — what must be true before Phase N+1 begins
- **Open Questions** — unresolved decisions that must be answered before or during build

### 2. `BUILD-STATUS.md`

A live implementation tracker pre-populated from the spec. Include every section below:

- **Header** — how to use this file: update status in the same PR or commit as the work; valid status values are `not started`, `in progress`, `blocked`, and `done`; if scope changes, update the source doc and this file together; when a workstream is marked `done`, add a short note with the last meaningful milestone
- **Snapshot** — last updated date, current target phase, implementation repo path, and any important initial notes
- **Done So Far** — anything already completed before this tracker was created (leave empty with a note if nothing is done yet)
- **Phase N Workstreams** — one section per phase; if an `IMPLEMENTATION_PLAN.md` exists, derive workstreams and task lists from it rather than inventing them. For each workstream:
  - Status (set to `not started` initially)
  - Source of truth — specific section(s) in the spec, roadmap, or other docs that define this workstream's requirements
  - Left to build — a concrete bullet list of implementation tasks remaining
  - Notes — constraints, gotchas, or decisions specific to this workstream
- **Open Blockers** — known blockers with no current resolution (leave as "None recorded yet" if empty)

---

> **Goal:** These documents should give an AI coding assistant full context on where the project stands, what phase it is in, and what to build next — without requiring a codebase audit or human explanation at the start of each session.
