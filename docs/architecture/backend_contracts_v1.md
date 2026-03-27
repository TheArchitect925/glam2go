# Backend Contracts V1

## Purpose
Define the practical backend-facing contract shape Glam2GO should target next without pretending the remote integration already exists.

## Session And Access

### Session summary
- `userId`
- `role`
- `displayName`
- `email`
- `artistProfileId` optional
- `isNewAccount`

### Protected continuation
This remains client-owned for now:
- `pendingPath`
- `requirement`
- `preferredAuthIntent`
- `artistId` optional

Backend does not need to own continuation semantics initially.

## Customer Profile
- `displayName`
- `email`
- `phoneNumber`
- `memberSince`

## Favorites
- `customerId`
- `artistIds[]`

## Saved Addresses
- `id`
- `label`
- `addressLine1`
- `unitDetails`
- `cityArea`
- `accessNotes`
- `isDefault`

## Notification Preferences
- `bookingUpdates`
- `artistResponses`
- `reminders`
- `promotions`

## Notification Delivery Registration
- `userId`
- `role`
- `platform`
- `deviceId`
- `token`
- `permissionState`
- `appEnvironment`

Current Phase 15 client status:
- no real token registration yet
- client boundary exists for session-aware delivery readiness and future device registration

## Artist Public Profile
- `artistId`
- `displayName`
- `bio`
- `experienceSummary`
- `instagramHandle`
- `tiktokHandle`
- `specialties[]`
- `portfolioItems[]`
- `travelPolicy`

Current Phase 14 mutation paths:
- `GET /v1/artist/me/management`
- `PUT /v1/artist/me/profile`
- response may return either `{ "profile": {...} }`, `{ "artistProfile": {...} }`, `{ "profileDraft": {...} }`, or a wider wrapped management object

## Artist Portfolio Item
- `id`
- `title`
- `category`
- `caption`
- `mediaUrl` optional
- `mediaReference` optional
- `displayOrder` optional

Current Phase 15 mutation paths:
- `POST /v1/artist/me/portfolio`
- `PUT /v1/artist/me/portfolio/{portfolioItemId}`
- `DELETE /v1/artist/me/portfolio/{portfolioItemId}`
- response may return `{ "portfolioItem": {...} }`, `{ "portfolio": {...} }`, `{ "item": {...} }`, or no item payload with follow-up refresh

## Artist Package
- `id`
- `artistId`
- `title`
- `description`
- `price`
- `durationMinutes`
- `includes[]`
- `suitableOccasions[]`
- `isActive`

Current Phase 14 mutation paths:
- `POST /v1/artist/me/packages`
- `PUT /v1/artist/me/packages/{packageId}`
- response may return either `{ "package": {...} }`, `{ "artistPackage": {...} }`, or rely on follow-up management refresh

## Artist Availability
- `artistId`
- `days[]`
  - `dayKey`
  - `isAvailable`
  - `windows[]`
    - `id`
    - `startLabel`
    - `endLabel`

Current Phase 14 mutation path:
- `PUT /v1/artist/me/availability`
- accepted response shapes:
  - `{ "availabilityDays": [...] }`
  - `{ "availability": [...] }`
  - raw list payload

## Travel Policy
- `primaryServiceArea`
- `includedRadiusKm`
- `extraTravelFee`
- `maxTravelDistanceKm`
- `travelNotes`

Current Phase 14 mutation path:
- `PUT /v1/artist/me/travel-policy`
- response may return either `{ "travelPolicy": {...} }`, `{ "serviceArea": {...} }`, or rely on follow-up management refresh

## Booking Request

### Submit request payload
- `customerId`
- `artistId`
- `packageId`
- `eventDetails`
- `date`
- `time`
- `location`
- `travelFeeSummary` client estimate placeholder
- `priceSummary` client estimate placeholder
- `originatedAsGuest`

Current Phase 12 transport path:
- `POST /v1/bookings/requests`

### Booking lifecycle record
- `id`
- `customerId`
- `customerName`
- `artistId`
- `artistName`
- `packageId`
- `packageTitle`
- `status`
- `scheduledAt`
- `timeLabel`
- `location`
- `eventDetails`
- `travelFeeSummary`
- `priceSummary`
- `requestedAt`
- `isUpcoming`
- `policySummary`
- `nextStepNote`
- `timeline[]`

Current Phase 12 retrieval path:
- `GET /v1/bookings`
- the client currently accepts either a raw list response or `{ "bookings": [...] }`

### Lifecycle statuses
- `pendingArtistResponse`
- `accepted`
- `declined`
- `cancelled`
- `completed`

### Lifecycle mutation endpoints
- `POST /v1/bookings/{bookingId}/decision`
  - body: `{ "decision": "accept" | "decline" }`
- `POST /v1/bookings/{bookingId}/cancel`

## API Preparation Notes
- booking lifecycle should remain one shared contract across customer and artist views
- artist setup and public artist discovery can diverge in storage shape later, but should still map back to the same public-profile domain
- favorites, addresses, and preferences can ship behind lightweight endpoints; they do not need complex orchestration
- avoid baking UI-only copy into backend responses unless the field is truly business-owned
- lifecycle mutation responses should return the updated booking record so customer and artist views stay on one canonical status source
- artist-management mutation responses are now tolerant of partial payloads, but backend follow-up should converge on stable wrapped response keys so repository merge logic can stay minimal
- portfolio media upload and notification token registration should be treated as separate contracts from preferences or metadata saves
