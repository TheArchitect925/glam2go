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
- `lib/core/config/*`
- `lib/core/network/*`
- `lib/core/theme/*`
- `lib/core/l10n/localization.dart`
- `lib/shared/widgets/*`

Current feature-layer implementations:
- session and role state under `lib/features/session/{domain,data,application}`
- discovery data and search selectors under `lib/features/search/{domain,data,application}`
- booking draft flow under `lib/features/booking/{domain,application,presentation}`
- shared marketplace booking lifecycle under `lib/features/booking/{domain,data,application}`
- customer account state under `lib/features/profile/{domain,data,application}` with downstream consumers in bookings, favorites, and profile/settings screens
- artist setup and operations state under `lib/features/artist_management/{domain,data,application}` with downstream consumers in onboarding, dashboard, profile management, packages, availability, bookings, and settings

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

## Current Booking Choice
Booking uses one feature-owned draft controller instead of scattered per-screen state. Marketplace booking lifecycle now sits behind a repository boundary so request submission, artist response, and persistence do not depend on direct mock imports.

## Current Account Choice
Customer account management uses one repository-backed account-data layer under the profile feature. Bookings, favorites, settings, saved addresses, and support summaries read from this shared account layer instead of each feature inventing a second local store.

## Current Artist Choice
Artist-side management also uses one repository-backed feature-owned state layer. The app now stays role-aware inside one router tree, one `ProviderScope`, and two shells, rather than splitting customer and artist experiences into disconnected app architectures.

## Current Session Choice
Guest, customer, and artist behavior now flow through one session provider. Protected actions keep browsing context as structured pending-action data, and the active session now restores through a feature-owned repository and storage boundary rather than widget-local flags or route-only assumptions.

## Current Data Choice
The app now uses a simple canonical data pattern:
- domain models and repository contracts in feature `domain`
- DTOs, storage adapters, and repository implementations in feature `data`
- controllers/providers in feature `application`
- widgets and screens in feature `presentation`

This keeps local persistence and future remote integration behind stable feature contracts without introducing enterprise-scale abstraction.

## Current Remote Boundary Choice
Remote integration is now expected to flow through one app-level network boundary:
- `AppApiClient` in `lib/core/network`
- feature-owned remote data sources added under feature `data`
- repository implementations deciding whether to call local or remote sources

This avoids a second networking stack or widget-driven API access as real backend work begins.
