# MVP_DOCUMENT.md

## Project Overview

BlockParty is a web app for neighbors to list, reserve, and pick up free household items within a five-mile radius. The MVP targets one city launch with a responsive Next.js app, a Supabase backend, and an admin dashboard for trust and safety review.

| Area | Choice |
| --- | --- |
| Frontend | Next.js 15 App Router, TypeScript, Tailwind CSS |
| Backend | Supabase Postgres, Supabase Auth, Edge Functions |
| Storage | Supabase Storage for item photos |
| Hosting | Vercel for web, Supabase for data and auth |
| Observability | Sentry, Vercel Analytics |

## Design System

| Token | Value | Usage |
| --- | --- | --- |
| `pine-900` | `#18392B` | primary headings, nav text |
| `leaf-600` | `#3F8F5F` | primary actions, success badges |
| `sand-100` | `#F6F1E8` | page background |
| `clay-300` | `#D8C7B0` | borders and dividers |
| `tomato-600` | `#C94B32` | destructive actions, error banners |

Typography uses `Manrope` for headings at weights 600 and 700, and `Source Sans 3` for body text at weights 400 and 600. Cards use `0 12px 30px rgba(24, 57, 43, 0.08)` and 16px radius.

## Pages & Features

| Page | Key UI | Behavior |
| --- | --- | --- |
| `/` | hero, search bar, category chips, latest listings grid | search updates query string, grid paginates at 24 items |
| `/items/[id]` | photo carousel, description, pickup window, reserve button | reserve disabled for owner, expired, or reserved items |
| `/post` | title, category, condition, description, 4-photo uploader, address autocomplete | draft autosaves every 10 seconds for signed-in users |
| `/account/listings` | tabs for active, reserved, completed | allows mark as picked up and relist |
| `/admin/review` | flagged listings queue, approve/remove actions, reporter history panel | only moderators and admins can access |

## Data Architecture

### Tables

| Table | Fields |
| --- | --- |
| `users` | `id uuid pk`, `email text unique`, `display_name text`, `home_zip text`, `role text default 'member'`, `created_at timestamptz` |
| `items` | `id uuid pk`, `owner_id uuid fk users.id`, `title text`, `category text`, `condition text`, `description text`, `status text`, `pickup_zip text`, `pickup_lat numeric`, `pickup_lng numeric`, `expires_at timestamptz`, `created_at timestamptz` |
| `item_images` | `id uuid pk`, `item_id uuid fk items.id`, `storage_path text`, `sort_order int` |
| `reservations` | `id uuid pk`, `item_id uuid fk items.id unique`, `reserved_by uuid fk users.id`, `reserved_at timestamptz`, `status text` |
| `reports` | `id uuid pk`, `item_id uuid fk items.id`, `reported_by uuid fk users.id`, `reason text`, `notes text`, `created_at timestamptz` |

### API Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/items` | list items with `category`, `zip`, `cursor` filters |
| `GET` | `/api/items/:id` | fetch item detail |
| `POST` | `/api/items` | create listing |
| `POST` | `/api/items/:id/reserve` | reserve available listing |
| `POST` | `/api/items/:id/report` | submit abuse report |
| `POST` | `/api/admin/items/:id/moderate` | approve, hide, or remove listing |

## Permissions & Access Control

| Role | Can do |
| --- | --- |
| `guest` | browse public listings, view item detail |
| `member` | create listings, reserve items, report abuse, manage own listings |
| `moderator` | review reports, hide listings, restore listings |
| `admin` | all moderator actions plus manage moderator roles |

Protected routes: `/post`, `/account/*`, and `/admin/*`. Enforcement uses middleware for route gating, server-side role checks in actions and API handlers, and RLS policies for table-level access.

## Admin Workflow

1. Moderator opens `/admin/review` and sees the oldest unresolved report first.
2. Moderator reviews listing content, reporter notes, and prior moderation history.
3. Moderator chooses `approve`, `hide`, or `remove`.
4. System writes moderation audit log and notifies the listing owner by email.
5. Weekly admin review checks false-positive rate and average review time.

## User Flows

1. Post item:
   Sign in, open `/post`, complete required fields, upload photos, submit listing, land on item detail page.
2. Reserve item:
   Open listing, confirm pickup interest, see success state, owner receives email and in-app notification.
3. Report listing:
   Open listing menu, choose reason, submit notes, see confirmation toast, report enters moderation queue.

## Empty States

| Area | Empty state |
| --- | --- |
| home feed | "No items match this area yet" with clear-filters action |
| account listings | illustration, "You haven't posted anything yet", CTA to `/post` |
| admin queue | "No reports waiting" with last processed timestamp |

## Responsive Breakpoints

| Breakpoint | Width | Layout |
| --- | --- | --- |
| mobile | `<640px` | single-column cards, bottom sticky reserve button |
| tablet | `640px-1023px` | 2-column listing grid, condensed filters |
| desktop | `>=1024px` | 4-column listing grid, persistent sidebar filters |

## Error Handling

API errors return `{ code, message, requestId }`. Validation errors show inline field copy. Reservation conflicts return `409` with "This item was reserved a moment ago." All server errors go to Sentry with user ID and route metadata.

## Security

Use Supabase Auth session cookies, server-only service role keys, MIME and size validation for uploads, HTML escaping for user-generated text, and signed image URLs. External links open with `rel="noopener noreferrer"`.

## Project Structure

```text
app/
  (marketing)/          public landing and browse pages
  account/              authenticated account pages
  admin/                moderation dashboard
  api/                  route handlers
components/
  items/                listing cards, carousels, forms
  ui/                   shared buttons, inputs, badges
lib/
  auth/                 auth helpers and role checks
  db/                   Supabase clients and query helpers
  validation/           Zod schemas
docs/                   generated specs and ADRs
```

## Environment Variables

| Name | Side | Secret | Purpose |
| --- | --- | --- | --- |
| `NEXT_PUBLIC_SUPABASE_URL` | client | no | Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | client | no | public anon key |
| `SUPABASE_SERVICE_ROLE_KEY` | server | yes | admin and cron tasks |
| `SENTRY_DSN` | server | yes | error reporting |
| `RESEND_API_KEY` | server | yes | transactional email |

`.env.example` should include placeholders for all variables and comments noting that service keys are never exposed to the browser.

## Testing Strategy

Unit test validation schemas and moderation helpers. Component test listing forms, reserve modal states, and moderation controls. E2E test posting, reserving, reporting, and moderator review. First tests to write: duplicate reservation conflict, RLS enforcement, and image upload validation.

## Implementation Order

1. Create database schema, RLS policies, and storage buckets.
2. Implement auth and role-gated route protection.
3. Build browse and item detail pages.
4. Build listing creation flow with image uploads.
5. Build reservation flow and notifications.
6. Build report and moderation workflow.
7. Add analytics, Sentry, and E2E coverage.
