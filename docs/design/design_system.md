# Design System

## Direction
Glam2GO should feel premium, soft, and polished without becoming vague or overly decorative. The app must support fast booking, trust, and clean service comparison.

## Color Roles
- `primary`: soft rose brand CTA
- `primarySoft`: blush-tinted selected and supportive states
- `secondary`: warm muted neutral for secondary emphasis
- `accent`: cocoa-toned anchor color for stronger text and supporting actions
- `background`: soft cream page background
- `surface`: warm white base surface
- `surfaceVariant`: blush-beige grouped surface
- `surfaceMuted`: warmer neutral grouping surface
- `textPrimary`: high-contrast dark text
- `textSecondary`: readable secondary copy
- `textMuted`: low-emphasis neutral copy
- `success`, `warning`, `error`, `info`: semantic feedback
- `successSoft`, `warningSoft`, `errorSoft`, `infoSoft`: soft semantic fills
- `borderSubtle`: dividers, strokes, and input borders
- `shadowSoft`, `shadowMedium`: restrained elevation only

Locked palette intent:
- warm, cosmetic-service tones
- no cold tech blues as the default brand language
- no page-level hex styling outside the token layer

## Typography Roles
- `display`
- `headline`
- `title`
- `body`
- `label`
- `caption`

Rules:
- readability first
- title and price hierarchy must be strong
- avoid over-stylized scripts for core UI
- `display`: page hero moments only
- `headline`: section anchors
- `title`: cards, list groups, and pricing anchors
- `body`: readable content and summary copy
- `label`: chips, buttons, tabs, and metadata

## Spacing Scale
- 4, 8, 12, 16, 20, 24, 32, 40, 48
- build layout rhythm from the shared spacing scale only
- avoid one-off `EdgeInsets` values outside that scale

## Radius Scale
- small: 8
- medium: 12
- large: 16
- extraLarge: 24
- hero: 28
- pill: 999

Usage:
- cards: `extraLarge`
- compact surfaces and media frames: `large`
- inputs: `medium`
- chips/status/tag elements: `pill`

## Elevation And Shadow Style
- soft shadows
- low visual noise
- rely on surface contrast before strong shadow depth
- primary cards use one soft shadow treatment only
- no harsh Material elevation stacks
- hero surfaces use the same border and shadow language as cards

## Button Hierarchy
- primary button: main conversion action
- secondary button: supporting action
- tertiary/text button: low-emphasis action
- destructive button: limited, explicit use only

Locked button rules:
- height: 52
- rounded corners: `extraLarge`
- no per-screen button color overrides
- icon support belongs in the canonical shared button, not screen-local variants

## Cards
- use cards for artist summaries, packages, and booking summaries
- card layout should prioritize title, trust signals, price, and next action
- avoid overly dense card content
- all cards should flow through `AppCard`
- grouped account/policy/summary cards can use the muted surface tone
- hero panels should flow through the canonical hero surface rather than ad hoc containers

## Form Fields
- strong labels
- clear validation
- support address, date/time, note, and profile editing flows
- keep fields spacious and readable

## Chips And Tags
- use for occasion tags, package tags, and lightweight filters
- keep variants limited and documented
- selectable chips should inherit the shared theme
- static tags and status pills should flow through the shared tag system
- selected state must read clearly without relying on heavy saturation

## Bottom Navigation
- customer shell only
- clear labels and restrained icon set
- no route duplication through hidden nav patterns
- selected state uses soft rose indicator and cocoa-toned text/icon emphasis

## Aesthetic Rule
Premium beauty-service aesthetic should come from disciplined color, spacing, typography, and imagery treatment, not glittery decoration or overloaded gradients.

## Locked Component Rules
- `AppButton` is the canonical button entry point
- `AppCard` is the canonical surface entry point
- `AppHeroCard` is the canonical premium banner/hero surface
- `AppTag` is the canonical static chip/tag surface
- status pills, package tags, specialty tags, and date tags should not invent their own styling
