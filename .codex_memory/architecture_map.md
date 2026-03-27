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
- `session`
- `auth`
- `onboarding`
- `home`
- `search`
- `artist_profile`
- `booking`
- `favorites`
- `bookings`
- `profile`
- `artist_management`
- `artist_onboarding`
- `artist_dashboard`
- `artist_profile_management`
- `artist_packages`
- `artist_availability`
- `artist_bookings`
- `artist_settings`

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
- `lib/features/*/presentation/screens` contains the current route-entry surfaces, while feature-owned `domain`, `application`, and `data` layers now exist where real local state is already justified

## Discovery Ownership
- `lib/features/search/domain/models/discovery_models.dart` holds the lightweight browse-side domain for artists, packages, portfolio, availability, travel, and reviews
- `lib/features/search/domain/repositories/discovery_repository.dart` defines the canonical discovery catalog read boundary
- `lib/features/search/data/mock_discovery_catalog.dart` is the single local discovery catalog source for this phase
- `lib/features/search/data/dtos/discovery_catalog_dto.dart` maps the remote discovery payload into the canonical browse-side domain
- `lib/features/search/data/remote/discovery_remote_data_source.dart` owns the first remote discovery read integration
- `lib/features/search/data/repositories/hybrid_discovery_repository.dart` is the current hybrid repository implementation
- `lib/features/search/application/discovery_providers.dart` owns browse/search filter state, async catalog loading, and snapshot fallback selectors for hybrid remote/local mode
- home and artist profile currently depend on this discovery layer rather than duplicating parallel mock sources

## Booking Ownership
- `lib/features/booking/domain/models/booking_models.dart` holds the canonical booking draft and step models
- `lib/features/booking/domain/models/marketplace_booking_models.dart` holds the shared booking lifecycle, request decision, timeline, and marketplace booking record models
- `lib/features/booking/domain/repositories/marketplace_booking_repository.dart` defines the canonical booking lifecycle persistence boundary
- `lib/features/booking/data/dtos/booking_submission_payload_dto.dart` maps booking draft and customer session context into the remote booking request payload
- `lib/features/booking/data/dtos/marketplace_booking_dto.dart` maps persisted booking records to domain-safe marketplace booking models
- `lib/features/booking/data/local_marketplace_booking_storage.dart` is the local storage adapter for marketplace booking records
- `lib/features/booking/data/remote/marketplace_booking_remote_data_source.dart` owns the first remote booking lifecycle read and mutation integration
- `lib/features/booking/data/repositories/local_marketplace_booking_repository.dart` is the local repository implementation and canonical fallback path
- `lib/features/booking/data/repositories/hybrid_marketplace_booking_repository.dart` is the current hybrid booking repository implementation
- `lib/features/booking/application/booking_flow_controller.dart` owns the single in-session booking draft state and derived booking selectors
- `lib/features/booking/application/marketplace_booking_providers.dart` now owns the async repository-backed marketplace request list, request submission, customer cancellation, and artist accept/decline state transitions
- booking screens do not duplicate pricing, travel, or package-selection state locally beyond temporary field controllers
- booking flow reuses discovery artist/package data instead of creating a second booking-specific artist catalog

## Account Ownership
- `lib/features/profile/domain/models/account_models.dart` holds the current local customer-account domain for bookings metadata, favorites, saved addresses, preferences, profile, and support summaries
- `lib/features/profile/domain/repositories/account_repository.dart` defines the canonical customer-account persistence boundary
- `lib/features/profile/data/mock_account_data.dart` is the single local seed source for this phase
- `lib/features/profile/data/dtos/account_storage_dto.dart` maps customer profile, saved addresses, favorites, and notification preferences for storage-safe persistence
- `lib/features/profile/data/local_account_storage.dart` now persists customer profile, notification preferences, favorites, and saved-address defaults locally
- `lib/features/profile/data/repositories/local_account_repository.dart` is the current local repository implementation
- `lib/features/profile/application/account_providers.dart` owns repository-backed account state, favorite toggles, saved-address default selection, preference persistence, and customer-facing booking mappings from marketplace records
- bookings, favorites, profile, settings, addresses, and support screens consume this account layer rather than inventing their own mock stores

## Session Ownership
- `lib/features/session/domain/models/session_models.dart` now holds guest, customer, and artist mode state plus auth status, pending protected action context, and lightweight session user summaries
- `lib/features/session/domain/repositories/session_repository.dart` defines the canonical session persistence boundary
- `lib/features/session/data/dtos/auth_session_dto.dart` maps the remote auth/session payload into the canonical session domain
- `lib/features/session/data/dtos/session_storage_dto.dart` maps stored session payloads to session domain models
- `lib/features/session/data/local_session_storage.dart` persists the active session locally for app restart and post-auth continuation
- `lib/features/session/data/remote/session_remote_data_source.dart` owns the first remote auth/session integration
- `lib/features/session/data/repositories/hybrid_session_repository.dart` is the current hybrid repository implementation
- `lib/features/session/application/session_providers.dart` owns the canonical repository-backed session state, remote auth completion hooks, pending protected action handling, role switching, and session restore
- guest gating, auth placeholder flows, and role-aware routing read from this layer rather than scattering booleans across screens and routes

## Artist Management Ownership
- `lib/features/artist_management/domain/models/artist_management_models.dart` holds the canonical local artist-side setup domain for onboarding, profile draft, portfolio metadata, packages, availability, travel policy, readiness, and artist booking summaries
- `lib/features/artist_management/domain/repositories/artist_management_repository.dart` defines the canonical artist setup persistence boundary
- `lib/features/artist_management/data/mock_artist_management_data.dart` is the single local source for artist supply-side setup in this phase
- `lib/features/artist_management/data/dtos/artist_management_state_dto.dart` maps artist setup state between storage and domain
- `lib/features/artist_management/data/local_artist_management_storage.dart` persists artist setup locally
- `lib/features/artist_management/data/remote/artist_management_remote_data_source.dart` owns the first remote artist-management mutation integration, including portfolio metadata mutations
- `lib/features/artist_management/data/repositories/local_artist_management_repository.dart` remains the local repository implementation and fallback path
- `lib/features/artist_management/data/repositories/hybrid_artist_management_repository.dart` is the current hybrid artist-management repository implementation
- `lib/features/artist_management/application/artist_management_providers.dart` owns repository-backed artist setup mutations, mutation-in-flight tracking, readiness derivation, and artist booking segmentation
- artist onboarding, dashboard, profile management, packages, availability, bookings, and settings consume this layer instead of creating separate local stores per screen

## Core Data Foundations
- `lib/core/result/app_result.dart` is the lightweight shared result boundary for repository operations that can fail without throwing into UI code
- `lib/core/errors/app_failure.dart` defines canonical failure types and user-safe failure metadata
- `lib/core/config/app_environment.dart` and `lib/core/config/app_config.dart` define environment selection and app-level config flags outside widget code
- `lib/core/network/app_api_client.dart` defines the canonical remote-client contract for future feature data sources
- `lib/core/network/http_app_api_client.dart` is the current concrete HTTP implementation
- `lib/core/network/network_providers.dart` owns app-level API-client injection
- `lib/core/notifications/notification_service.dart` owns the canonical notification-delivery readiness boundary
- `lib/core/analytics/analytics_service.dart` owns the canonical product-event instrumentation boundary
- `lib/core/crash_reporting/crash_reporting_service.dart` owns the canonical crash and error reporting boundary
- repositories own storage and DTO mapping concerns; controllers should depend on repository contracts, not storage engines or raw maps

## Current Shared UI Additions
- `lib/shared/widgets/artist_package_card.dart` is the canonical package/service card
- `lib/features/search/presentation/widgets/artist_summary_card.dart` is the canonical artist listing card for discovery surfaces
- `lib/shared/widgets/app_hero_card.dart` is the canonical premium hero/banner surface
- `lib/shared/widgets/app_tag.dart` is the canonical non-interactive tag/pill primitive
- `lib/shared/widgets/booking_status_pill.dart` is the canonical booking-status treatment
- `lib/shared/widgets/favorite_artist_card.dart`, `address_card.dart`, `settings_tile.dart`, `profile_section_group.dart`, and `info_policy_card.dart` are the canonical account-layer presentation primitives
- `lib/shared/widgets/app_shell.dart` now owns both the customer shell and the artist shell without introducing a second app architecture
- artist-profile-specific widgets stay under `lib/features/artist_profile/presentation/widgets`

## Current Constraint
- Discovery, session, account, booking lifecycle, and artist-management modules now have repository-backed feature-owned domain/application/data baselines.
- Do not bypass repositories from providers or widgets by reading mock datasets, storage adapters, or raw DTOs directly unless the file is the repository implementation itself.
- Use mock data only as canonical seed data inside feature data layers or synchronous repository defaults. Do not reintroduce screen-local sample objects.
- Artist-side tooling now follows the same rule. Do not create a second artist setup store or a disconnected artist-only app tree.
- Guest, customer, and artist access now also follow one canonical session model. Do not add route-local role flags or one-off access booleans when the session provider should own the decision.
- Notification delivery, analytics, and crash reporting now also follow one canonical core-service model. Do not add widget-local instrumentation SDK calls or feature-local notification managers.
