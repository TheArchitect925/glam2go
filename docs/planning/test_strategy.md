# Test Strategy

## Goal
Protect critical marketplace flows while keeping the test suite lean enough to stay fast during integration work.

## Current Test Layers
- smoke tests for app boot
- widget tests for discovery, booking review, account surfaces, artist surfaces, notifications
- widget tests for support and policy surfaces
- provider/controller tests for session, booking lifecycle, artist management
- core-service tests for notification delivery readiness
- repository tests for local persistence boundaries plus hybrid remote/local session, discovery, booking, and artist-management flows

## Priority Regression Coverage
1. session restore and router redirects
2. guest to protected-action conversion
3. booking request submission and status rendering
4. artist accept/decline flow
5. repository persistence and mapping
6. booking mutation submission and decision handling
7. artist profile/package/availability/travel mutation handling
8. artist portfolio metadata mutation handling
9. notification delivery readiness state should not regress account or route behavior
10. support and policy routes should remain reachable from release-critical surfaces

## Next Test Additions During API Hookup
- remote DTO mapper tests
- repository fallback tests for local vs remote wiring
- route tests for auth restore into destination
- request failure and retry tests
- hybrid booking repository tests for submit, load, and mutation paths
- hybrid artist-management repository tests for profile/travel/package mutations and fallback behavior
- portfolio mutation tests and metadata mapper coverage
- notification service readiness and session-binding tests

## Release-Candidate Confidence Suite
- app boot smoke
- router guard coverage for guest, customer, artist, and policy routes
- support and policy surface rendering
- booking request critical path
- artist request handling critical path
- launch-sensitive loading and error states on discovery, booking, and artist-management surfaces

## Rules
- prefer feature-owned unit or provider tests for data mutations
- add widget tests only for high-value user-facing flows
- do not create shallow snapshot-style tests with no behavior assertions
- when a flow moves from local to remote, keep contract and mapper tests near the repository implementation
