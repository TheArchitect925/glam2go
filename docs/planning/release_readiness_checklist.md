# Release Readiness Checklist

## Internal Testing Ready When
- app boots reliably
- guest browsing works
- protected action conversion works
- booking request flow works end-to-end locally
- artist request review works end-to-end locally
- session restore works for guest, customer, and artist
- remote session restore is verified in the target environment when `ENABLE_REMOTE_SESSION=true`
- remote discovery/profile read is verified in the target environment when `ENABLE_REMOTE_DISCOVERY=true`
- remote booking lifecycle is verified in the target environment when `ENABLE_REMOTE_BOOKINGS=true`
- remote artist mutations are verified in the target environment when `ENABLE_REMOTE_ARTIST_MANAGEMENT=true`
- localization build passes
- no debug-only shortcuts are enabled outside development

## Blockers For External Beta
- favorites/profile/preferences not server-backed
- notification delivery is structurally wired but not platform-token-backed
- analytics and crash reporting are structurally wired but not connected to production vendors
- artist setup media upload is metadata-ready but not upload-backed
- no real media pipeline or storage moderation path

## Public Launch Blockers
- customer account APIs are still local-only for favorites, addresses, profile, and notification preferences
- policy and legal copy is still draft content
- notification delivery, analytics, and crash reporting are not vendor-connected
- portfolio media upload and storage remain unimplemented

## QA Focus Areas
- guest browse to protected action prompt
- sign-in/sign-up continuation target
- request submitted vs accepted wording
- customer booking status updates
- artist request accept/decline
- artist profile/package/availability/travel saves
- artist portfolio metadata add/edit/remove flow
- booking submission failure and retry
- sign-out and role switching
- notification delivery readiness state by guest/customer/artist session
- instrumentation should not affect route safety or booking flow correctness
- session restore into correct shell
- empty, loading, and recoverable error states

## Stability Watchpoints
- provider restore ordering
- router redirects after hydration
- stale role state after sign-out or mode switching
- local persistence restoring invalid old shapes

## Localization Watchpoints
- request vs confirmation language
- artist vs customer terminology
- notification category labels
- support/policy copy

## Pre-TestFlight Validation
- analyze passes
- tests pass
- no development-only account shortcuts in release builds
- API base URL is environment-correct
- critical routes do not expose the wrong role surface
- remote-integration flags match the backend environment under test
- booking lifecycle endpoints return contract-safe records in the target environment
- artist mutation endpoints return contract-safe wrapped payloads or refresh-safe state in the target environment
- portfolio mutation endpoints return contract-safe metadata payloads when `ENABLE_REMOTE_ARTIST_MANAGEMENT=true`
- notification, analytics, and crash-reporting flags match the beta environment under test

## Pre-Public-Launch Validation
- replace all editable legal draft content with approved copy
- finalize support contact destination
- confirm customer account APIs are remotely backed or explicitly removed from public release scope
- confirm production observability and notification vendor hookup status
