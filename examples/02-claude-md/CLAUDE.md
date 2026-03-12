# CLAUDE.md

## What this is

BeaconOps is a B2B incident follow-up platform used by support teams to track outages, coordinate customer updates, and publish postmortems. It is an actively developed monorepo with one production web app and one internal admin app.

## Tech stack

- Runtime: Node.js 22, TypeScript
- Frontend: Next.js 15 App Router, React 19, Tailwind CSS
- Backend: Next.js route handlers and server actions
- Database: PostgreSQL via Prisma
- Queue: Trigger.dev for scheduled and async work
- Hosting: Vercel
- Third-party: Clerk auth, Resend email, Sentry, PostHog

## Key commands

```bash
pnpm install
pnpm dev
pnpm build
pnpm test
pnpm lint
pnpm prisma migrate dev
pnpm check
```

## Project structure

```text
apps/
  web/                  customer-facing app
  admin/                internal operations app
packages/
  db/                   Prisma schema, generated client, seed scripts
  ui/                   shared design system components
  config/               eslint, tsconfig, tailwind presets
docs/                   product specs, ADRs, runbooks
```

## Architecture notes

- All database access goes through `packages/db/src/client.ts`.
- Server actions live under `apps/web/app/**/actions.ts`.
- Background jobs are defined in `apps/web/src/jobs/`.
- Customer-facing API routes are in `apps/web/app/api/`.
- Admin-only reads must still enforce role checks on the server, not just hidden navigation.

## Conventions

- Use kebab-case for route segments and PascalCase for React components.
- Prefer server components unless a hook or browser API is required.
- Validate all external input with Zod before it reaches Prisma.
- Keep feature-specific UI under `apps/web/src/features/<feature>/`.
- Add tests beside complex helpers and in `tests/e2e/` for user-visible flows.

## Environment variables

| Name | Where used | Purpose | Secret |
| --- | --- | --- | --- |
| `DATABASE_URL` | server | primary Postgres connection | yes |
| `CLERK_SECRET_KEY` | server | auth backend operations | yes |
| `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` | client | auth client bootstrapping | no |
| `RESEND_API_KEY` | server | transactional email | yes |
| `SENTRY_DSN` | server | error reporting | yes |
| `NEXT_PUBLIC_POSTHOG_KEY` | client | product analytics | no |

## Do not

- Do not edit generated Prisma client files.
- Do not bypass `packages/db` with ad hoc database clients.
- Do not commit `.env` files or production secrets.
- Do not put admin authorization checks only in the frontend.

## Where to start

- `apps/web/app/page.tsx`
- `apps/web/app/api/incidents/route.ts`
- `packages/db/prisma/schema.prisma`
- `apps/web/src/jobs/sendIncidentDigest.ts`
- `docs/architecture.md`
