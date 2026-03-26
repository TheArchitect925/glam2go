# Navigation Architecture

## Approach
Use `go_router` with a small set of top-level route groups and a shell route for authenticated customer navigation.

## Top-Level Groups
- public: splash, onboarding, auth
- customer shell: home, bookings, favorites, profile
- discovery detail: search results, artist profile, package detail
- booking flow: date/time, location, checkout, confirmation

## Shell Guidance
- one authenticated customer shell
- bottom navigation for core customer destinations
- detail screens should sit outside the tab shell when they represent drill-down flows

## Current Implemented Shell
- public entry: splash then onboarding/auth routes
- authenticated shell destinations: home, search, bookings, favorites, profile
- detail routes currently outside the shell: artist profile, package detail, booking flow, booking detail, profile edit, settings

## Rules
- add routes by business experience, not by widget convenience
- keep route names stable
- use path params for identities and query params only for lightweight filters
- every routing change must update the memory route map

## V1 Constraint
Do not overbuild nested navigation for artist-side tooling until that scope is active.

## Current Routing Constraint
Portfolio, reviews, phone verification, and artist-management routes remain intentionally unimplemented in code until those passes start.
