# Backend Integration Execution Plan

## Current Position
- auth/session, discovery reads, booking lifecycle, and artist operational mutations are already in hybrid remote/local mode
- remaining public-launch integration gap is customer account data plus vendor/platform service hookup

## Goal
Move Glam2GO from repository-backed local behavior to real service integration without changing feature UX architecture or creating parallel data paths.

## Integration Principles
- Integrate behind existing feature repository contracts.
- Add remote data sources before replacing local implementations.
- Keep local repositories available for tests and controlled fallback.
- Do not mix transport DTOs into presentation or controller code.
- Hook up read APIs before mutation-heavy workflows when that reduces risk.

## Recommended Integration Sequence

### Phase A: session and identity
- Hook up customer sign-in and sign-up
- Hook up artist sign-in and join flow
- Persist server-backed session summary
- Preserve guest conversion and pending protected actions client-side

Current status:
- hybrid remote/local session repository is implemented
- remote auth endpoints are mapped behind a feature remote data source
- local persistence still bridges restore and protected-action continuation

Dependencies:
- final auth API contract
- identity/session restore behavior
- role summary payload with optional `artistProfileId`

Risk areas:
- losing protected-action continuation
- role mismatch after auth restore
- dev-only default account shortcuts leaking into non-development builds

### Phase B: discovery read APIs
- discovery feed
- artist profile read
- package read
- availability preview read

Current status:
- hybrid remote/local discovery repository is implemented
- home, search, artist profile, package detail, and booking entry now support async remote loading with retry handling
- current remote assumption is a single catalog endpoint that can hydrate list and detail surfaces

Dependencies:
- stable artist/profile/package contract
- media URL strategy
- list/detail mapping consistency

Risk areas:
- customer discovery UI currently assumes curated local completeness
- media and rating fields may arrive partially populated

### Phase C: booking request submission and lifecycle
- booking request submit
- customer booking list/detail
- artist request list/detail
- accept/decline
- customer cancellation rules

Current status:
- hybrid remote/local marketplace booking repository is implemented
- booking review now submits through the canonical booking repository contract
- customer bookings list/detail and artist request review now read from the shared async lifecycle source
- artist accept/decline and customer cancel now route through repository-backed mutations
- local repository behavior remains the fallback when booking APIs are disabled

Dependencies:
- booking request contract
- lifecycle event/status contract
- server-side status ownership

Risk areas:
- request vs confirmed wording must stay accurate
- lifecycle must remain one shared source across customer and artist views
- stale local records must not survive once remote source-of-truth exists
- backend customer and artist list payloads still need consistent detail completeness for shared mapping

### Phase D: customer account APIs
- favorites
- saved addresses
- profile
- notification preferences

Dependencies:
- authenticated account APIs
- stable customer profile identity

Risk areas:
- guest conversion side effects for favorites
- local defaults conflicting with remote account state

### Phase E: artist mutation APIs
- artist profile management
- package mutations
- availability mutations
- service area and travel policy mutations
- onboarding/readiness sync

Current status:
- hybrid remote/local artist management repository is implemented
- artist profile, package, availability, and travel-policy mutations now route through the canonical artist repository
- local repository behavior remains the fallback when artist mutation APIs are disabled
- artist dashboard summaries now reflect repository-backed mutation state rather than screen-local drafts

Dependencies:
- artist identity linked to public artist profile
- mutation validation rules
- readiness ownership split between client and backend

Risk areas:
- package and availability shape drift from customer-facing read models
- backend response keys for profile/package/travel updates still need to converge
- media/portfolio upload remains outside the current mutation wave

### Phase F: portfolio media and observability plumbing
- portfolio metadata mutation stabilization
- media upload and stored-reference hookup
- notification device registration
- analytics vendor hookup
- crash-reporting vendor hookup

Current status:
- portfolio metadata mutations now route through the canonical artist-management repository
- notification delivery, analytics, and crash reporting now have canonical core-service boundaries behind environment flags
- app bootstrap now captures fatal Flutter and platform errors through the crash-reporting boundary

Dependencies:
- media storage contract
- notification token contract
- vendor selection and environment provisioning

Risk areas:
- fake-looking upload flows if media storage remains unavailable
- instrumentation noise or duplicated event ownership
- environment drift between beta and production observability stacks

### Release Candidate Hardening Layer
- support and policy surfaces
- release docs and submission planning
- final wording and route discoverability polish

Current status:
- shared support hub and dedicated privacy, terms, cancellation, and booking-policy routes are implemented
- release docs now cover TestFlight, App Store submission, permissions, release notes, and support/policy surface mapping

Dependencies:
- final legal and operations copy review
- final launch-channel configuration review

## Temporary Fallback Rules
- Keep local-only repository implementations available for tests and preview environments.
- Do not let UI choose between local and remote implementations directly.
- Repository wiring should decide source selection.
- If a remote feature is partially integrated, prefer explicit read-only support over fake full CRUD.

## Readiness Gate Before Real API Work
- repository contract exists
- DTO mapping exists or is explicitly unnecessary
- error/failure mapping path exists
- route/session behavior is covered by regression tests
- user-visible copy is accurate for partial integration states

## Immediate Engineering Order
1. Session/auth remote data source
2. Discovery and artist-profile read data sources
3. Marketplace booking lifecycle remote data source
4. Artist management remote data source
5. Customer account remote data source
6. Media upload and observability vendor integration
