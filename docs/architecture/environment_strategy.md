# Environment Strategy

## Goal
Keep environment concerns out of widgets and feature controllers unless they are explicitly app-level configuration.

## Current App Config
`lib/core/config/app_config.dart` is the canonical app configuration entry point.

Current config includes:
- environment selection
- API base URL placeholder
- local persistence enablement
- debug default account enablement
- booking lifecycle timeline visibility flag

Current networking foundation:
- `AppApiClient` is the canonical remote-client boundary
- `PlaceholderApiClient` is the current non-production implementation
- real API clients should be injected through the same provider layer rather than instantiated inside features

## Source Of Truth
Use compile-time environment values for now:
- `APP_ENV`
- `API_BASE_URL`
- `ENABLE_LOCAL_PERSISTENCE`
- `ENABLE_DEBUG_DEFAULT_ACCOUNTS`
- `ENABLE_LIFECYCLE_TIMELINE`
- `ENABLE_REMOTE_BOOKINGS`
- `ENABLE_REMOTE_ARTIST_MANAGEMENT`

## Rules
- do not put secrets in source
- do not hardcode API URLs in feature widgets
- do not gate product behavior with scattered `bool.fromEnvironment` calls across the codebase
- all environment-sensitive behavior should flow through `AppConfig`
- development-only shortcuts must default off outside development unless explicitly enabled

## Expected Next Step
When real backend work begins:
- add authenticated and unauthenticated API clients under `lib/core`
- keep endpoint paths and base URL assembly outside features
- add staging/prod build configuration through the same config layer
- keep artist mutation rollout gated through `ENABLE_REMOTE_ARTIST_MANAGEMENT` until the target environment is contract-stable
