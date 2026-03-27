# Production Cutover Checklist

## Environment And Backend
- Confirm `APP_ENV=production`
- Confirm production `API_BASE_URL`
- Confirm `ENABLE_REMOTE_SESSION=true`
- Confirm `ENABLE_REMOTE_DISCOVERY=true`
- Confirm `ENABLE_REMOTE_BOOKINGS=true`
- Confirm `ENABLE_REMOTE_ARTIST_MANAGEMENT=true`
- Confirm debug default accounts are disabled
- Confirm backend contracts match the currently shipped DTO shapes

## Release Safety
- Confirm no development-only routes, banners, or shortcuts are visible
- Confirm environment-specific logging is disabled unless intentionally needed
- Confirm crash-reporting toggle matches the production vendor state
- Confirm analytics toggle matches the production vendor state
- Confirm notification-delivery toggle matches the actual platform capability

## Product Flows
- Verify guest browse and protected-action conversion
- Verify customer sign-in, sign-up, sign-out, and session restore
- Verify discovery, artist profile, and package detail loading
- Verify booking request submission and customer booking detail rendering
- Verify artist request inbox plus accept and decline mutations
- Verify artist profile, package, availability, travel-policy, and portfolio metadata saves
- Verify support, privacy, terms, cancellation, and booking-policy routes

## Content And Policy
- Replace draft legal content with approved copy or explicitly keep launch in beta-only mode
- Review App Store copy against actual shipped capability
- Review privacy disclosure notes against enabled SDKs and permissions
- Confirm support contact method is finalized

## Build And Submission
- Increment build and version numbers
- Confirm release notes are updated
- Confirm screenshots and metadata match the current build
- Run `flutter analyze`
- Run `flutter test`

## Hold Criteria
- Any broken auth restore or route-loop behavior
- Any request-vs-confirmation wording regression in booking flow
- Any customer or artist lifecycle mutation failing in production-like env
- Missing or misleading legal/policy copy in a public release candidate
- Production observability still blind after launch toggle decisions
