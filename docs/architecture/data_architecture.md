# Data Architecture

## Goal
Move Glam2GO from direct mock-backed feature state to a repository-backed architecture that keeps current behavior intact while preparing clean swap points for remote services.

## Canonical Pattern
- domain models remain the app-facing business language
- repository interfaces live under each feature `domain/repositories`
- repository implementations live under each feature `data/repositories`
- local storage helpers stay inside feature `data`
- DTOs exist only where serialization or transport shape differs from the domain model
- presentation depends on application providers only
- application providers depend on repository interfaces, not mock constants

## Implemented Repositories
- `SessionRepository`
  - owns load/save/clear for session restore and protected-action continuation
- `DiscoveryRepository`
  - owns read access to discovery catalog data
- `MarketplaceBookingRepository`
  - owns shared booking lifecycle reads plus request and decision mutations
- `AccountRepository`
  - owns customer profile, preferences, favorites, addresses, and policy summary seed access
- `ArtistManagementRepository`
  - owns artist setup reads plus profile, package, portfolio, availability, travel-policy, and readiness mutations

## Current Local Data Sources
- `LocalSessionStorage`
- `LocalAccountStorage`
- `LocalMarketplaceBookingStorage`
- `LocalArtistManagementStorage`

These are implementation details. Controllers should not depend on them directly.

## Remote Boundary Foundation
- `lib/core/network/app_api_client.dart` defines the canonical API-client boundary
- `lib/core/network/placeholder_api_client.dart` is the non-production implementation until real HTTP hookup begins
- `lib/core/network/network_providers.dart` is the app-level injection point for future remote data sources
- `lib/core/notifications/notification_service.dart` defines the canonical notification-delivery readiness boundary
- `lib/core/analytics/analytics_service.dart` defines the canonical product-event instrumentation boundary
- `lib/core/crash_reporting/crash_reporting_service.dart` defines the canonical crash and non-fatal error reporting boundary

When real API work starts, feature remote data sources should depend on `AppApiClient`, not on ad hoc HTTP calls inside repositories or controllers.

## DTO Boundary
DTOs are currently justified for:
- session persistence
- customer account persistence
- marketplace booking persistence
- marketplace booking submission payloads and remote lifecycle transport
- artist management persistence and remote mutation transport, including portfolio item metadata

DTOs are not yet justified for:
- booking draft state

Those remain domain-safe enough for the current phase and do not yet need storage or transport duplication.

## Remote Preparation Rule
When backend integration starts, add feature-owned remote data sources beside the current local ones:
- `data/data_sources/local/...`
- `data/data_sources/remote/...`

Do not create a parallel UI code path. Replace repository implementation wiring, not presentation logic.

## Provider Rule
- providers may compose repository data
- providers may map domain to UI-safe derived values
- providers must not import mock constants directly when a repository already owns that responsibility
- instrumentation services should be called from controllers, repositories, or app bootstrap boundaries, not directly from widgets unless no canonical seam exists
