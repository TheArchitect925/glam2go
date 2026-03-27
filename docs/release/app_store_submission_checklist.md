# App Store Submission Checklist

## Product Readiness
- verify release build boots cleanly
- verify guest, customer, and artist flows do not expose the wrong shell
- verify request-state booking wording stays accurate
- verify support and policy surfaces are reachable from settings and booking detail

## Configuration
- disable debug default accounts
- confirm production-safe environment flags
- confirm release API base URL
- confirm analytics, crash, and notification flags match launch intent

## Content
- finalize App Store name, subtitle, keywords, and feature summary
- finalize privacy policy URL or embedded-hosting plan
- finalize terms, cancellation, and booking-policy copy
- prepare reviewer notes for hybrid or limited-release functionality

## Quality Gate
- `flutter analyze` passes
- `flutter test` passes
- release blockers are explicitly reviewed
- known beta-only limitations are documented for reviewers and testers

## Public Release Rule
- do not submit a public V1 build while [launch_blockers.md](/Users/shahabmansoor/Developer/glam2go/docs/release/launch_blockers.md) still contains unresolved public-launch blockers
