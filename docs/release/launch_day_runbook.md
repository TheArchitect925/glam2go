# Launch Day Runbook

## 1. Pre-Launch Verification
- Re-run the production cutover checklist
- Confirm backend environment health with the engineering owner
- Confirm App Store or TestFlight metadata, release notes, and reviewer notes are final
- Confirm legal and operations sign-off status

## 2. Final Build Validation
- Install the release candidate on a clean device
- Verify session bootstrap for guest, customer, and artist
- Verify one customer booking request flow
- Verify one artist accept or decline flow
- Verify support and policy routes

## 3. Go Or Hold Decision
- Use [go_no_go_assessment.md](/Users/shahabmansoor/Developer/glam2go/docs/release/go_no_go_assessment.md) as the source of truth
- If any hold criteria from the cutover checklist fail, do not proceed

## 4. Launch Window Actions
- Publish or promote the approved build
- Turn on only the environment flags that match verified production services
- Capture the exact build number, environment, and flag state in the release log

## 5. First-Hour Monitoring
- Watch auth restore failures
- Watch booking submission failures
- Watch artist request mutation failures
- Watch crash and analytics ingestion if vendors are enabled
- Watch support escalations for policy or booking-language confusion

## 6. Rollback Triggers
- Auth or session bootstrap failures affecting sign-in or sign-out
- Broken booking submission or artist decision mutations
- Severe route-protection leak between guest, customer, and artist surfaces
- Legal or policy content issue requiring immediate correction

## 7. Post-Launch Follow-Up
- Log any hotfix-worthy issues for `V1.0.1`
- Update release notes if operational guidance changes
- Convert beta-only caveats into tracked post-launch items
