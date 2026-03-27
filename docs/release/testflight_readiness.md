# TestFlight Readiness

## Must Be True Before Upload
- production-like environment config is selected
- debug-only shortcuts are disabled
- crash and analytics flags are intentional for the beta build
- key customer and artist journeys were manually sanity-checked
- the current go/no-go recommendation still allows a controlled beta build

## Tester Guidance
- treat booking submission as a request until accepted
- report any route that opens the wrong role surface
- report any stale booking or artist-setup data after sign-out or restore
- report any support or policy surface that feels hidden or inconsistent
- report any account-management mismatch across devices, especially for favorites, addresses, and profile/preferences

## Known Beta Limitations
- favorites, addresses, and customer preferences are still local-backed
- portfolio metadata is supported, but media upload is not connected
- notification delivery structure exists, but push transport is not connected

## Decision Reference
- use [go_no_go_assessment.md](/Users/shahabmansoor/Developer/glam2go/docs/release/go_no_go_assessment.md) as the release-status source of truth
