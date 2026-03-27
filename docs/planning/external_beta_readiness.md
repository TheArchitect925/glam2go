# External Beta Readiness

## Structurally Ready
- hybrid remote/local auth and session restore
- hybrid remote/local discovery reads
- hybrid remote/local booking lifecycle submission and artist decisions
- hybrid remote/local artist setup mutations
- hybrid remote/local artist portfolio metadata mutations
- notification delivery readiness boundary
- analytics event boundary
- crash-reporting boundary
- centralized support and policy route surfaces

## Still Blocked
- remote favorites, saved addresses, and customer preferences
- real media upload, storage, and moderation
- real device-token registration and push delivery
- production analytics vendor hookup
- production crash-reporting vendor hookup
- final legal copy approval for public release

## External Beta Gate
- all beta builds must disable debug default accounts
- environment flags must reflect the intended backend and observability stack
- hybrid features must degrade without broken widgets or route leaks
- customer and artist request lifecycle must be validated on the target backend before broad rollout

## Public Release Position
- external beta can proceed in a controlled way once environment flags and backend lifecycle checks are verified
- public release should remain blocked until customer account APIs, vendor hookups, and final legal copy are complete
