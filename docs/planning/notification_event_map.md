# Notification Event Map

## Event Types
- `bookingRequestSubmitted`
  - recipient: artist
  - source: marketplace booking submission
- `bookingAccepted`
  - recipient: customer
  - source: artist decision
- `bookingDeclined`
  - recipient: customer
  - source: artist decision
- `bookingStatusUpdated`
  - recipient: customer or artist
  - source: future generalized lifecycle updates
- `bookingReminder`
  - recipient: customer
  - source: future reminder scheduler
- `artistOperationalAlert`
  - recipient: artist
  - source: future supply-side operational events

## Current Scope
- delivery structure exists
- role-aware event mapping exists
- platform token registration and push transport remain blocked pending backend/platform configuration
