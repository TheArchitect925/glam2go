# V1 Known Gaps

## Mock-Backed But Stable
- customer account persistence
- notification delivery vendor hookup
- analytics vendor hookup
- crash-reporting vendor hookup
- support contact destination

## Hybrid Remote/Local
- auth and session bootstrap
- discovery feed
- artist profile and package read
- booking submission and lifecycle sync
- artist profile/package/availability/travel mutations
- artist portfolio metadata mutations

## Blocked Pending Backend
- remote favorites, addresses, and preferences
- portfolio media upload and storage
- device-token registration and push delivery

## Blocked Pending UX Or Product Decisions
- payment and checkout handoff
- cancellation policy enforcement
- reschedule flow
- review authoring
- portfolio upload experience

## High-Risk Integration Areas
- booking lifecycle ownership between customer and artist views
- artist identity to public profile mapping
- travel fee estimate ownership
- readiness logic ownership once backend validation exists

## Internal Testing Caveats
- local persistence can make flows look more complete than backend reality
- booking lifecycle correctness now depends on `ENABLE_REMOTE_BOOKINGS=true` plus stable backend mutation contracts
- artist operational correctness now depends on `ENABLE_REMOTE_ARTIST_MANAGEMENT=true` plus stable wrapped mutation responses
- notification preferences are UI-ready and delivery-structure-backed, but not yet connected to platform token or push vendors

## Public Launch Caveats
- current legal and policy screens are structurally ready but still draft content
- current account-management experience is not fully cross-device trustworthy until customer account APIs are connected
