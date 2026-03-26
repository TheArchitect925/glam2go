# Route Map

## Routing Principles
- Keep routing predictable and feature-owned.
- Prefer a small set of top-level experiences.
- Use route params only for real identity: artist id, booking id, package id.
- Do not create parallel routes for the same screen intent.

## Proposed Initial Top-Level Structure

### Public and auth
- `/splash`
- `/onboarding`
- `/auth/sign-in`
- `/auth/sign-up`
- `/auth/verify-phone` if needed

### Customer shell
- `/home`
- `/search`
- `/bookings`
- `/favorites`
- `/profile`

Use a shell route for the main authenticated customer tabs.

## Discovery and artist flow
- `/search/results`
- `/artists/:artistId`
- `/artists/:artistId/portfolio`
- `/artists/:artistId/packages/:packageId`
- `/artists/:artistId/reviews`

## Booking flow
- `/booking/start`
- `/booking/artist/:artistId/package/:packageId`
- `/booking/date-time`
- `/booking/location`
- `/booking/checkout`
- `/booking/confirmation/:bookingId`

Notes:
- `checkout` should allow payment-intent placeholder architecture in V1 without pretending payment is fully integrated if it is not.
- Keep booking flow linear and resumable.

## Customer account
- `/bookings/:bookingId`
- `/profile/edit`
- `/settings`
- `/support` later if needed

## Artist-side routes
Not default V1 customer shell routes. Add only when artist-side management enters active implementation.
- `/artist/dashboard`
- `/artist/profile/edit`
- `/artist/packages`
- `/artist/availability`
- `/artist/travel-policy`

## Routing Scope Notes
- Customer discovery and booking are V1 priorities.
- Artist management routes are likely V1.5 unless onboarding artists is part of the first release plan.
- Every new route must update this file and `/docs/architecture/navigation_architecture.md`.

## Implemented In The Current Baseline
- Implemented now:
  - `/splash`
  - `/onboarding`
  - `/auth/sign-in`
  - `/auth/sign-up`
  - `/home`
  - `/search`
  - `/search/results`
  - `/bookings`
  - `/favorites`
  - `/profile`
  - `/artists/:artistId`
  - `/artists/:artistId/packages/:packageId`
  - `/booking/start`
  - `/booking/start/artist/:artistId/package/:packageId`
  - `/booking/date-time`
  - `/booking/location`
  - `/booking/checkout`
  - `/booking/confirmation/:bookingId`
  - `/bookings/:bookingId`
  - `/profile/edit`
  - `/settings`
- Not implemented yet:
  - `/auth/verify-phone`
  - `/artists/:artistId/portfolio`
  - `/artists/:artistId/reviews`
  - any artist management route under `/artist/...`

## Baseline Behavior Notes
- The authenticated customer shell currently uses five destinations: home, search, bookings, favorites, and profile.
- Route screens are intentionally scaffolded and clearly incomplete rather than pretending to be production features.
