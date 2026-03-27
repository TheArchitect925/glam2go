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

Guest behavior:
- guest users can browse `/home`, `/search`, `/search/results`, `/artists/:artistId`, and package detail routes
- guest users can explore the booking flow, but final request submission should gate into sign-in/create-account
- splash now restores the last local session and routes authenticated users back into the correct customer or artist area
- authenticated users should not remain on onboarding, sign-in, or sign-up routes once a valid session exists

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
- `/booking/details`
- `/booking/date`
- `/booking/time`
- `/booking/location`
- `/booking/review`
- `/booking/confirmation/:bookingId`

Notes:
- `checkout` should allow payment-intent placeholder architecture in V1 without pretending payment is fully integrated if it is not.
- Keep booking flow linear and resumable.

## Customer account
- `/bookings/:bookingId`
- `/profile/edit`
- `/profile/addresses`
- `/settings`
- `/settings/notifications`
- `/support`
- `/support/privacy`
- `/support/terms`
- `/support/cancellation`
- `/support/booking-policy`

Access behavior:
- `/bookings`, `/favorites`, `/profile`, `/profile/edit`, `/profile/addresses`, and `/settings` are customer-gated surfaces
- use graceful in-screen gating for customer account routes instead of a harsh early auth wall

## Artist-side routes
- `/artist/onboarding`
- `/artist/dashboard`
- `/artist/bookings`
- `/artist/settings`
- `/artist/profile`
- `/artist/portfolio`
- `/artist/packages`
- `/artist/availability`
- `/artist/service-area`

## Routing Scope Notes
- Customer discovery and booking are V1 priorities.
- Artist management now exists as a local foundation inside the shared app, but it is still not a connected production operations stack.
- artist management routes are redirect-protected from guest and customer modes unless the session is in artist mode
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
  - `/booking/details`
  - `/booking/date`
  - `/booking/time`
  - `/booking/location`
  - `/booking/review`
  - `/booking/confirmation/:bookingId`
  - `/bookings/:bookingId`
  - `/profile/edit`
  - `/profile/addresses`
  - `/settings`
  - `/settings/notifications`
  - `/support`
  - `/support/privacy`
  - `/support/terms`
  - `/support/cancellation`
  - `/support/booking-policy`
  - `/artist/onboarding`
  - `/artist/dashboard`
  - `/artist/bookings`
  - `/artist/settings`
  - `/artist/profile`
  - `/artist/portfolio`
  - `/artist/packages`
  - `/artist/availability`
  - `/artist/service-area`
- Not implemented yet:
  - `/auth/verify-phone`
  - `/artists/:artistId/portfolio`
  - `/artists/:artistId/reviews`

## Baseline Behavior Notes
- The customer shell currently uses five destinations: home, search, bookings, favorites, and profile.
- Guest users can still enter that shell, but protected tabs now render conversion gates instead of account content.
- The shared app now also includes a three-destination artist shell: dashboard, bookings, and settings.
- Booking now runs as a multi-step draft flow: service, details, date, time, location, review, request-submitted confirmation.
- Artist/package handoff still enters through `/booking/start` and `/booking/start/artist/:artistId/package/:packageId`.
- The customer account layer now adds non-shell drill-down routes for booking detail, profile editing, saved addresses, settings, and help/policies.
- Notification preferences now live at `/settings/notifications` and render role-aware customer or artist controls from the same shared app.
- Legal and booking-policy surfaces now live under the shared support route group so privacy, terms, cancellation, and booking guidance stay centralized instead of being duplicated in settings or booking detail.
- Artist setup currently enters from onboarding and sign-up, then branches into the artist shell plus detail routes for profile management, portfolio, packages, availability, and service area.
- Shared marketplace wiring now means artist accept/decline actions update the same booking record the customer sees in bookings and booking detail.
- Auth entry routes now redirect authenticated users back to their canonical customer or artist destination, and completed artists no longer linger on onboarding.
