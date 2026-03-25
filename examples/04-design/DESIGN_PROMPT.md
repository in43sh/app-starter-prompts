# DESIGN_PROMPT.md

## Master Prompt

```text
Design a responsive neighborhood marketplace web app called BlockParty. The product helps nearby residents give away household items, reserve them, and coordinate pickup. The visual direction should feel trustworthy, practical, and warm - never luxury, futuristic, or startup-hype.

Brand intro:
- Personality: grounded, friendly, dependable
- Overall feel: a modern community bulletin board with strong clarity and quiet warmth
- Avoid: glassmorphism, neon gradients, crypto aesthetics, glossy ecommerce polish, oversized hero gimmicks

Brand & Colors:
- Pine 900 `#18392B` - primary headings, main navigation text, footer background accents. Do not use for destructive actions.
- Leaf 600 `#3F8F5F` - primary CTAs, positive badges, success states. Do not use for body text on light backgrounds.
- Sand 100 `#F6F1E8` - main page background and soft section fills. Keep it dominant so the interface feels calm.
- Clay 300 `#D8C7B0` - borders, dividers, muted icons, input outlines.
- Tomato 600 `#C94B32` - destructive actions, error banners, moderation removal states.
- Ink 900 `#1A1F1C` - body text on light surfaces.
- Fog 500 `#6E776F` - secondary text, helper copy, timestamps.
- White `#FFFFFF` - cards, modals, elevated surfaces.

Typography:
- Headings: Manrope, 700 for primary headings and 600 for section headings
- Body: Source Sans 3, 400 for body copy and 600 for emphasized inline text
- Hero headline: 56px / 60px on desktop, 36px / 40px on mobile
- H2: 32px / 36px
- H3: 24px / 30px
- Body: 18px / 28px
- Small label: 14px / 20px
- Caption: 13px / 18px
- Use slightly tighter tracking on large headings and tabular numbers for counters or timestamps

Layout Rules:
- Max content width: 1280px
- Spacing rhythm: 12px, 16px, 24px, 32px, 48px, 72px
- Layout feel: spacious and airy, but not sparse
- Border radius: 16px for cards and modals, 12px for inputs, full pill for chips and badges
- Shadow style: soft and low-contrast, such as `0 12px 30px rgba(24, 57, 43, 0.08)`
- Responsive behavior: mobile-first, stacked cards and filters on small screens, multi-column browse layout on desktop, sticky bottom CTA on mobile item pages

Component Style:
- Cards: white background, 1px clay border, soft shadow, generous padding, subtle hover lift only on interactive cards
- Primary button: leaf green background, white text, 16px vertical rhythm, semi-bold label, slightly darker hover, no glossy gradients
- Secondary button: white or sand background, pine text, clay border, subtle hover fill
- Destructive button: tomato background, white text, reserved for moderation and delete flows
- Inputs: white background, 1px clay border, 12px radius, pine text, visible green focus ring with no heavy glow
- Chips and badges: pill shape, small uppercase or semi-bold labels, muted sand or clay backgrounds for filters, green or tomato accents only when status matters
- Navigation: top navbar on desktop with clear search access, compact mobile header with menu and post CTA, no oversized marketing nav
- Images: 4:3 ratio for listing cards, rounded corners, neutral placeholder with item silhouette if missing
- Empty states: light illustration or icon, one clear sentence, one next-step CTA
- Motion: minimal and purposeful - only subtle fade/slide on modals and hover lift on cards

What to avoid:
- No centered walls of text in hero sections
- No dark mode unless explicitly requested later
- No heavy border treatments on every element
- No purple accents, glossy blobs, or abstract SaaS backgrounds
- No tiny text or cramped table layouts
```

## Page Specs

### Home / Browse

- Purpose: Help neighbors discover nearby free items quickly and confidently.
- Layout: Marketing-style hero at the top, followed by search/filter controls and a multi-column listing grid. On mobile, filters collapse into a drawer and the grid becomes a single column.
- UI elements:
  - Simple top navigation with wordmark, browse link, post-item CTA, and account entry
  - Hero headline, short supporting copy, ZIP search input, and category chips
  - Filter bar with category, condition, distance, and sort controls
  - Listing card grid with photo, title, category, pickup area, and reservation state
  - Empty state panel when no listings match
- States to show:
  - default browse
  - filtered results
  - no results
  - loading skeleton cards
- Variant prompt:

```text
Design the BlockParty home and browse page using the BlockParty brand system. Show a warm sand background, a left-aligned hero with strong Manrope heading, a practical search input, category chips, and a responsive listing grid of white cards with soft shadows. On mobile, collapse filters into a drawer and keep the post-item CTA prominent but not oversized.
```

### Item Detail

- Purpose: Help a user decide whether to reserve an item and understand pickup expectations.
- Layout: Large image area with detail content beside it on desktop; stacked layout on mobile with a sticky reserve action at the bottom.
- UI elements:
  - Photo carousel with fallback placeholder
  - Item title, condition badge, pickup area, and posted timestamp
  - Description body and pickup notes
  - Primary reserve button plus secondary report action
  - Owner-safe messaging that confirms this is a free neighborhood exchange
  - Related items row beneath the main content
- States to show:
  - available
  - reserved
  - expired
  - owner viewing own listing
  - network error on reserve attempt
- Variant prompt:

```text
Design the BlockParty item detail page with a large but calm photo-first layout, grounded typography, and a sticky mobile reserve CTA. The reserve action should feel clear and inviting, while status states like reserved or expired should remain calm and readable instead of dramatic.
```

### Post Listing

- Purpose: Let a signed-in user create a listing with as little friction as possible.
- Layout: Centered form shell with clear step grouping, generous spacing, and a right-side help panel on desktop that collapses below the form on mobile.
- UI elements:
  - Form title and reassurance copy
  - Inputs for title, category, condition, description, and pickup ZIP
  - Four-image uploader with drag-and-drop and thumbnail previews
  - Draft saved indicator
  - Primary submit button and secondary save-for-later action
  - Inline validation and helper text
- States to show:
  - empty form
  - validation errors
  - draft saved
  - upload in progress
  - successful submission
- Variant prompt:

```text
Design the BlockParty listing creation page as a calm, highly usable form with generous spacing, clear field groups, and a friendly but practical tone. Use white cards on a sand background, strong helper text, and a photo uploader that feels simple rather than technical.
```

### Admin Review

- Purpose: Help moderators review flagged listings quickly and make consistent trust-and-safety decisions.
- Layout: Two-column dashboard on desktop with a queue on the left and listing detail plus action panel on the right. On mobile, stack the queue and detail sections with sticky moderation controls.
- UI elements:
  - Queue list with status badges, report counts, and timestamps
  - Listing detail summary with photos, description, and report notes
  - Reporter history panel
  - Approve, hide, and remove action buttons
  - Audit log section with prior decisions
- States to show:
  - active queue
  - no reports waiting
  - selected listing under review
  - destructive action confirmation modal
- Variant prompt:

```text
Design the BlockParty admin review screen with a serious but not intimidating tone. Use the same brand system as the customer app, but tighten spacing slightly, emphasize scanability, and make moderation actions clear with strong status color usage only where decisions matter.
```

## Component Variant Prompts

### Listing Card

```text
Design a BlockParty listing card with a 4:3 image, soft white card surface, pine title text, muted metadata, a small condition badge, and a restrained hover lift. It should feel neighborly and useful, not like premium ecommerce.
```

### Reserve Button Group

```text
Design a primary and secondary CTA pair for the BlockParty item page. The primary reserve button should use the leaf green brand color with confident but calm emphasis. The secondary action should be a quieter outlined button for reporting or other low-frequency actions.
```

### Filter Chip Row

```text
Design a horizontal row of BlockParty filter chips for category, condition, and distance. Use pill shapes, subtle clay borders, and sand-toned inactive states. Active chips should feel selected without becoming loud or overly saturated.
```

### Moderation Queue Row

```text
Design a moderation queue row for BlockParty admin review with clear hierarchy for item title, report reason, timestamp, and status badge. Keep it compact and highly scannable, with tomato used only for urgent or destructive states.
```
