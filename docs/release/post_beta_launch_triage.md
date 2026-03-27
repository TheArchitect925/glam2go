# Post-Beta Launch Triage

## Must-Fix Before Public Launch
- Remote customer-account APIs are still missing for favorites, saved addresses, customer profile, and notification preferences.
  - Severity: critical
  - User impact: customers can complete core marketplace flows but daily account-management behavior is still local-only and not production-trustworthy across devices
  - Dependency: backend plus repository hookup
  - Recommendation: block public launch until these flows are remotely backed or explicitly removed from the public release scope
- Final legal and operations copy is still draft content on privacy, terms, cancellation, and booking-policy surfaces.
  - Severity: critical
  - User impact: App Store and public users would see provisional policy language
  - Dependency: legal and operations review
  - Recommendation: replace placeholder copy and verify links before public launch
- Notification delivery, analytics, and crash-reporting services are structurally ready but not connected to production vendors.
  - Severity: high
  - User impact: launch would have weak observability and no real push delivery despite visible readiness surfaces
  - Dependency: platform and vendor configuration
  - Recommendation: complete vendor hookup or explicitly disable the exposed readiness claims before launch
- Portfolio media upload and storage are still not connected.
  - Severity: high
  - User impact: artist portfolio feels incomplete and could create confusion if marketed as media-capable
  - Dependency: backend and media pipeline
  - Recommendation: either connect the media path or scope portfolio down to metadata-only beta behavior in public materials

## Should-Fix Before Public Launch If Feasible
- Add direct support/contact destination instead of a placeholder guidance card on the support screen.
  - Severity: medium
  - User impact: users can find help and policies, but they still lack a concrete support escalation path
  - Dependency: operations decision
  - Recommendation: add final contact method or support form destination before broader rollout
- Expand launch regression coverage around support, settings, and policy entry paths.
  - Severity: medium
  - User impact: low direct impact, but these are high-visibility release surfaces
  - Dependency: engineering
  - Recommendation: keep route and smoke coverage tight before release branch cut

## Safe To Defer Post-Launch
- Richer cancellation-policy enforcement and reschedule flows
- Review authoring
- Portfolio moderation workflows
- Advanced analytics segmentation and dashboards

## Blocked By Backend, Platform, Or Content Dependencies
- Device-token registration and actual push transport
- Production analytics vendor hookup
- Production crash-reporting vendor hookup
- Counsel-approved legal copy
- Customer account API contracts for favorites, addresses, profile, and preferences

## Launch Recommendation
- Public V1 launch: `no-go`
- Controlled external beta: `conditional go`
  - Conditions:
    - debug shortcuts disabled
    - remote auth, discovery, bookings, and artist-management flags verified in the target environment
    - beta testers informed that account-management sync and push delivery are still limited
