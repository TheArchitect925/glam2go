# Analytics Event Map

## Session And Access
- `appModeSelected`
- `signInSucceeded`
- `signInFailed`
- `signUpSucceeded`
- `signUpFailed`

## Booking Lifecycle
- `bookingRequestSubmitted`
- `artistRequestAccepted`
- `artistRequestDeclined`

## Artist Operations
- `artistProfileSaved`
- `artistPackageSaved`
- `artistAvailabilitySaved`
- `artistTravelPolicySaved`
- `artistPortfolioSaved`
- `artistPortfolioRemoved`

## Guardrails
- instrument from controllers, repositories, or bootstrap seams
- avoid widget-level event spam
- keep beta instrumentation focused on funnel and operational milestones
