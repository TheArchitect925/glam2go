# Domain Model

## Core Entities

### User
- id
- role
- displayName
- phone
- email
- profilePhotoUrl
- favoriteArtistIds

### Artist
- id
- publicName
- bio
- avatarUrl
- ratingSummary
- serviceRadiusKm
- socialLinks
- portfolioPreview
- travelPolicy
- serviceAreas

### ServicePackage
- id
- artistId
- title
- description
- basePrice
- durationMinutes
- includedServices
- addOns
- occasionTags
- isActive

### AvailabilityWindow
- id
- artistId
- startAt
- endAt
- recurrenceRule optional later
- status

### Booking
- id
- customerId
- artistId
- packageId
- appointmentStartAt
- appointmentEndAt
- serviceAddress
- priceBreakdown
- bookingStatus
- notes

### Address
- id optional
- label
- line1
- line2 optional
- city
- provinceOrState
- postalCode
- countryCode
- latitude
- longitude

### TravelPolicy
- includedRadiusKm
- extraDistanceFeeType
- extraDistanceFeeAmount
- maxTravelDistanceKm optional
- notes

### Review
- id
- bookingId
- customerId
- artistId
- rating
- comment
- createdAt

### PortfolioItem
- id
- artistId
- imageUrl
- caption
- tags
- sortOrder

### PaymentIntent Placeholder
- id
- bookingId
- amount
- currencyCode
- status
- providerReference optional

## Supporting Value Concepts
- `Money`
- `BookingStatus`
- `UserRole`
- `PriceBreakdown`
- `GeoPoint`
- `DistanceCharge`

## Modeling Notes
- Keep the booking price breakdown explicit.
- Travel policy must be modeled as business data, not informal UI text.
- Portfolio is trust-critical and should not be treated like generic media.
- Payment can remain a placeholder entity early, but booking flow must not pretend settlement logic is finished.

