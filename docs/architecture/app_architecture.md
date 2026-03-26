# App Architecture

## Recommended Stack
- Flutter
- Riverpod for state management
- go_router for navigation
- Flutter `gen-l10n` for localization

## Structural Direction
- `lib/app`: app bootstrap, router, theme, localization, app shell
- `lib/core`: cross-cutting services and foundations
- `lib/features`: feature-first modules
- `lib/shared`: shared UI and presentation helpers

Current baseline files:
- `lib/app/app.dart`
- `lib/app/app_router.dart`
- `lib/app/app_providers.dart`
- `lib/core/theme/*`
- `lib/core/l10n/localization.dart`
- `lib/shared/widgets/*`

## Feature Module Shape
Each feature should own:
- `domain`
- `application`
- `presentation`
- optional `data` when repository implementation and mapping are needed

## Why This Shape
- prevents shared dumping grounds
- keeps business language near the feature
- limits route and state drift
- scales from a small app to a production codebase

## Guardrails
- no second architecture track
- no page-first chaos where business logic lives inside widgets
- no fake repository abstraction unless there is a real consumer
- no feature folders without a clear owner and roadmap position

## Current Baseline Choice
This pass implements presentation-first feature scaffolds so routing, theming, localization, and shared primitives are stable before domain/application layers expand.
