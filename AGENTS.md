# Glam2GO Codex Operating Guide

## Project Identity
- Project: Glam2GO
- Platform: Flutter mobile app
- Targets: iOS first, Android first-class in the same codebase
- Product type: beauty services marketplace and booking platform
- Status: foundational operating-system pass

## Product Summary
Glam2GO helps customers discover, evaluate, and book makeup artists for events and occasions. The product combines service discovery, transparent pricing, travel-aware booking, portfolio-driven trust, and artist-side business controls.

## Target User Types
- Customer: books makeup services for personal events
- Artist: configures services, travel radius, pricing, availability, and portfolio
- Platform/Admin: future operational actor for moderation, support, and marketplace quality

## Current Phase
This repo is in baseline stabilization. The goal is to lock architecture, naming, routing, documentation, and execution habits before building feature depth.

## Working Rules
- Build only against the approved docs and memory files in this repo.
- Keep changes small, reviewable, and aligned to the current implementation phase.
- Audit existing files before creating new ones.
- Extend canonical files instead of introducing alternates.
- Treat generated Flutter starter code as disposable unless explicitly adopted into the approved architecture.
- Do not build speculative features ahead of the roadmap.

## Architecture Rules
- Use a modular Flutter structure with `lib/app`, `lib/core`, `lib/features`, and `lib/shared`.
- Keep domain, application, and presentation concerns separated within feature modules.
- Reserve `lib/app` for bootstrap, app shell, theme, router, and app-wide composition.
- Reserve `lib/core` for cross-cutting foundations: config, errors, services, utilities, and platform abstractions.
- Reserve `lib/shared` for reusable UI primitives and shared presentation helpers.
- Do not introduce a second state-management pattern once the baseline strategy is chosen.
- Default architecture direction: Flutter + Riverpod + go_router with localization-ready strings.

## File Creation And Update Rules
- Read the existing implementation before editing.
- Prefer updating a canonical file over adding a sibling like `*_new.dart`, `*_v2.dart`, `temp_*`, or `final_*`.
- Do not create pages, widgets, or services that duplicate existing responsibilities.
- Do not add new top-level folders without updating the architecture docs.
- Remove obvious scaffold noise only when it is clearly non-canonical and safe to discard.

## Naming Conventions
- Use production-quality names that describe business intent, not temporary UI intent.
- Use singular entity names for models: `Artist`, `Booking`, `ServicePackage`.
- Use feature-first paths: `lib/features/discovery/...`, not ambiguous buckets.
- Use consistent suffixes: `Screen`, `Page`, `Controller`, `Repository`, `Provider`, `Entity`, `Model`, `Dto`.
- Route names must match documented route intent and remain stable.

## Localization Requirement
- All user-facing text must be localization-ready from the start.
- No hardcoded customer-facing strings in widgets once localization scaffolding exists.
- New screens are not complete until strings are prepared for localization.

## Navigation And Route Rules
- Do not add routes without updating `.codex_memory/route_map.md` and `/docs/architecture/navigation_architecture.md`.
- Keep routing shallow and intentional; avoid route sprawl.
- Prefer stable route ownership by feature.
- Avoid hidden navigation paths and ad hoc `Navigator.push` usage once router architecture is in place.

## UI Consistency Rules
- Shared UI primitives belong in `lib/shared`.
- Feature-specific UI stays inside the feature unless reused by multiple features.
- Reuse approved component variants rather than cloning and restyling existing widgets.
- Avoid giant god-widgets. Split presentation into readable, named components.

## Design-System-First Rule
- Theme, tokens, spacing, typography, color roles, and component hierarchy come before large UI buildout.
- New UI should be composed from documented design decisions, not one-off visual choices.
- Premium beauty-service aesthetic is required, but clarity and booking speed win over decoration.

## Documentation Update Rule
- Update docs and memory whenever architecture, routing, scope, naming, or workflow assumptions change.
- If code changes invalidate a document, update the document in the same pass.
- Do not leave roadmap, route, or architecture drift for later.

## Anti-Duplication Rule
- Never create duplicate pages if a page already exists and can be extended.
- Never rebuild a feature from scratch without first auditing the current implementation.
- Never create duplicate routes for the same experience.
- Never create alternate architecture patterns when an approved one already exists.

## Anti-Placeholder Rule
- Do not introduce fake complete features.
- Do not build placeholder screens that will obviously be thrown away.
- If a capability is not implemented, represent it honestly as planned, partial, or out of scope.

## Read These Files First Before Coding
Read these in order:
1. `/Users/shahabmansoor/Developer/glam2go/AGENTS.md`
2. `/Users/shahabmansoor/Developer/glam2go/.codex_memory/do_not_rebuild.md`
3. `/Users/shahabmansoor/Developer/glam2go/.codex_memory/architecture_map.md`
4. `/Users/shahabmansoor/Developer/glam2go/.codex_memory/route_map.md`
5. `/Users/shahabmansoor/Developer/glam2go/.codex_memory/feature_inventory.md`
6. `/Users/shahabmansoor/Developer/glam2go/.codex_memory/continuation_backlog.md`

## Always Update Memory After Meaningful Work
- After meaningful implementation, update the relevant memory files.
- At minimum, review route map, feature inventory, continuation backlog, and architecture map.
- If nothing changed, explicitly confirm that memory stayed valid in the final report.

## Definition Of Done For Each Pass
- The task goal is implemented or documented clearly.
- No duplicate files or routes were introduced.
- Relevant docs and memory were updated.
- Naming is consistent with the approved architecture.
- User-facing strings respect localization requirements or the documented localization plan.
- Scope remains aligned with V1 unless the task explicitly targets future planning.
- Final report includes audit notes, changed files, decisions, risks, and the next recommended prompt.

## Expected Final Report Format After Each Codex Task
Use this structure:
1. Audit summary
2. Files created
3. Files updated
4. Key decisions
5. Verification performed
6. Risks or open questions
7. Recommended next prompt

