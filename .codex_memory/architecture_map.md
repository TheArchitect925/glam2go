# Architecture Map

## Intended Flutter Structure

### `lib/app`
App-level composition only.
- bootstrap and app entry wiring
- app shell
- router configuration
- theme and design tokens
- localization bootstrap
- environment setup and app-wide providers

### `lib/core`
Cross-cutting foundations with no feature ownership.
- networking client setup
- persistence abstractions
- analytics/logging hooks
- error types and failure handling
- config, constants, utilities
- base services used by multiple features

### `lib/features`
Feature-first modules. Each feature owns its domain, application, and presentation concerns.

Recommended feature folders:
- `auth`
- `onboarding`
- `home`
- `search`
- `artist_profile`
- `booking`
- `favorites`
- `bookings`
- `profile`
- `artist_dashboard` later, once artist-side V1 work starts

Recommended internal feature structure:
- `domain/`
  - entities
  - value objects
  - repository contracts
- `application/`
  - controllers
  - use cases
  - state definitions
  - provider wiring
- `presentation/`
  - screens
  - widgets
  - view models or UI-only mappers when needed
- `data/` only when the feature has implementation-specific repositories, DTOs, or mappers

### `lib/shared`
Shared presentation assets and reusable UI.
- design-system widgets
- shared layout primitives
- common form widgets
- shared async/loading/error states
- shared extensions strictly related to presentation

### `test`
Mirror the app structure.
- app-level tests for bootstrap and routing
- feature tests grouped by feature
- widget tests for design-system primitives and stable screens
- domain tests for business logic and mapping

## Separation Rules

### App shell and bootstrap
Belongs in `lib/app`.
- app startup
- provider scope
- router mount
- theme mount
- localization delegates

### Core services
Belongs in `lib/core`.
- services reused by many features
- no feature-specific UI or business flows

### Shared UI
Belongs in `lib/shared`.
- reusable presentation primitives
- no feature business logic

### Feature modules
Belongs in `lib/features/<feature>`.
- own screens, state, domain logic, and data implementation

## Layer Boundaries
- Presentation depends on application and UI primitives.
- Application coordinates user intent, async work, and state transitions.
- Domain contains business concepts and repository contracts.
- Data implements repository contracts and external mapping.
- Shared and core should not become dumping grounds. If a file has clear feature ownership, keep it in the feature.

## Baseline Tooling Direction
- Router: `go_router`
- State: `riverpod`
- Localization: Flutter `gen-l10n`
- Theming: app-owned design tokens and component theming from day one

## Implemented Baseline
- `lib/main.dart` mounts a single `ProviderScope`
- `lib/app/app.dart` owns `MaterialApp.router`
- `lib/app/app_router.dart` owns canonical route registration and shell setup
- `lib/app/app_providers.dart` currently exposes only the app router provider
- `lib/core/theme` contains baseline tokens and theme wiring
- `lib/core/l10n/localization.dart` wraps generated localization access
- `lib/shared/widgets` contains the shared scaffold, buttons, cards, and state widgets
- `lib/features/*/presentation/screens` currently contains lean route-entry screens only

## Current Constraint
- Feature modules are presentation-first scaffolds in this pass.
- Domain, application, and data layers should be added only when the relevant feature pass starts real business logic work.
