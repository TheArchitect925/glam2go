# API Hookup Priorities

## Remaining Priority Order
1. customer account APIs: favorites, saved addresses, profile, notification preferences
2. portfolio media upload and stored media references
3. notification device registration and delivery transport
4. analytics and crash-reporting vendor hookup

## Priority Matrix

### 1. Session/Auth API
- Status: hybrid remote/local
- Why first: every protected flow depends on it
- Current local fallback: repository-backed local session persistence
- Blocking risks: protected-action resume, role restore, artist identity mapping

### 2. Discovery Feed And Artist Detail Read APIs
- Status: hybrid remote/local
- Why second: core marketplace value and earliest guest-facing path
- Current local fallback: curated discovery repository
- Blocking risks: portfolio/media shape, availability preview completeness, ratings source

### 3. Booking Request Submission API
- Status: hybrid remote/local
- Why third: first real conversion event
- Current local fallback: marketplace booking repository
- Blocking risks: request/confirmation wording, travel estimate ownership, conflict handling

### 4. Booking Lifecycle Update APIs
- Status: hybrid remote/local
- Why fourth: required to make customer and artist flows coherent after submission
- Current local fallback: shared lifecycle repository
- Blocking risks: canonical event timeline, accept/decline race handling, cancellation rules

### 5. Artist Request Review APIs
- Status: hybrid remote/local
- Why fifth: operational supply-side handling depends on lifecycle source-of-truth
- Current local fallback: artist bookings driven by shared lifecycle repository
- Blocking risks: artist identity scoping, request detail completeness

### 6. Artist Profile/Package/Availability Mutation APIs
- Status: hybrid remote/local
- Why sixth: supply-side quality now directly affects discovery quality and booking trust
- Current local fallback: artist management repository
- Blocking risks: stable wrapped response keys, package id assignment, readiness ownership

### 7. Favorites API
- Status: integration-ready
- Why sixth: low complexity, fast win after auth
- Current local fallback: account repository
- Blocking risks: guest conversion intent replay

### 8. Saved Addresses And Profile Preferences APIs
- Status: integration-ready
- Why seventh: useful but not conversion-blocking
- Current local fallback: account repository
- Blocking risks: default-address ownership, partial profile hydration

### 9. Notification Preferences API
- Status: integration-ready
- Why eighth: account quality improvement, not core booking blocker
- Current local fallback: account repository and artist management repository
- Blocking risks: role-specific categories, delivery capability mismatch

### 10. Portfolio Media Metadata And Upload APIs
- Status: hybrid metadata integration plus upload-ready structure
- Why ninth: required for stronger artist trust but not a blocker for the first booking lifecycle beta
- Current local fallback: artist management repository with portfolio metadata placeholders
- Blocking risks: upload storage contract, moderation path, media ordering rules

### 11. Notification Delivery Registration API
- Status: structurally ready
- Why tenth: useful for beta operations once push infrastructure exists
- Current local fallback: notification service readiness boundary only
- Blocking risks: platform token lifecycle, backend registration ownership, environment-safe vendor setup

## Do Not Prioritize Yet
- payment APIs
- payouts/earnings
- chat/messaging
- admin moderation
- analytics/crash event backends beyond structural placeholders
- legal-copy finalization should not block backend sequencing, but it does block public-release confidence

## Phase 11 Outcome
- session/auth is now the first remote-backed integration wave
- discovery and artist-profile/package read paths are now the first hybrid remote/local read wave
- booking lifecycle and artist/customer mutation flows remain local-backed for now

## Phase 12 Outcome
- booking request submission is now hybrid remote/local
- customer bookings retrieval is now hybrid remote/local
- artist request review and accept/decline are now hybrid remote/local
- customer cancellation is now hybrid remote/local

## Phase 14 Outcome
- artist profile mutations are now hybrid remote/local
- artist package create/edit/activate flows are now hybrid remote/local
- artist availability mutations are now hybrid remote/local
- artist travel-policy mutations are now hybrid remote/local

## Phase 15 Outcome
- artist portfolio metadata mutations are now hybrid remote/local
- notification delivery, analytics, and crash reporting now have canonical core-service boundaries
- actual media upload, device-token registration, and vendor-backed observability remain blocked pending platform/backend setup
