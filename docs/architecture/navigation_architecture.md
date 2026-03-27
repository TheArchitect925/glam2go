# Navigation Architecture

## Approach
Use `go_router` with a small set of top-level route groups and shell routes for the two active role surfaces inside one shared app.

## Top-Level Groups
- public: splash, onboarding, auth
- customer shell: home, bookings, favorites, profile
- artist shell: dashboard, bookings, settings
- discovery detail: search results, artist profile, package detail
- booking flow: date/time, location, checkout, confirmation

## Shell Guidance
- keep shell navigation role-aware but still inside one router tree
- bottom navigation for core customer destinations
- bottom navigation for the lean artist operational destinations
- detail screens should sit outside the tab shell when they represent drill-down flows

## Current Implemented Shell
- public entry: splash now restores the local session first, then routes into onboarding/auth or the correct signed-in area
- authenticated shell destinations: home, search, bookings, favorites, profile
- artist shell destinations: dashboard, bookings, settings
- detail routes currently outside the shell: artist profile, package detail, booking flow, booking detail, profile edit, saved addresses, settings, notification preferences, help/policies, policy detail surfaces, artist profile management, portfolio, packages, availability, and service area
- authenticated users are redirected away from onboarding, sign-in, and sign-up routes so auth-entry screens do not linger after session restore

## Current Booking Navigation
- booking is a linear route flow outside the shell
- current steps: service, details, date, time, location, review, confirmation
- returning to the service step reuses the existing in-session draft instead of requiring a fresh artist handoff
- guest users can move through booking exploration, but final request submission is gated until customer mode is active

## Rules
- add routes by business experience, not by widget convenience
- keep route names stable
- use path params for identities and query params only for lightweight filters
- every routing change must update the memory route map

## Current Artist Navigation
- artist onboarding is a public-to-artist handoff route
- artist operational navigation then lives under the artist shell
- artist detail/setup screens stay outside the shell so the operational tabs remain lean

## Current Routing Constraint
Portfolio and reviews as customer-facing artist-detail subroutes remain intentionally unimplemented. Phone verification and connected artist operations are also still out of scope.

## Current Access Model
- guest users can browse discovery and artist detail routes without an account
- customer-only routes use in-screen conversion gates to avoid an early hard auth wall
- protected actions now preserve a pending destination so sign-in or create-account can resume the correct route without restarting the user flow
- artist routes redirect back to artist onboarding unless the session is already in artist mode
- completed artists should be redirected away from artist onboarding into the artist dashboard

## Current Account Navigation Choice
- bookings detail stays outside the shell so it can behave like a focused drill-down rather than another tab surface
- profile-owned secondary routes now include edit profile, saved addresses, settings, support, and dedicated privacy/terms/cancellation/booking-policy surfaces
- help and policy information is centralized instead of being duplicated across booking and profile screens
