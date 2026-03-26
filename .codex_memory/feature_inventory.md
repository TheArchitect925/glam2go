# Feature Inventory

## V1 Core

### Customer onboarding and auth
- Purpose: identify users and support returning sessions
- Actor: customer
- Dependencies: auth provider, app shell, localization, basic profile model
- Notes/Risks: keep auth simple; avoid role-complexity too early

### Discovery home
- Purpose: let users browse nearby or relevant artists quickly
- Actor: customer
- Dependencies: location strategy, search filters, artist listing model, design system
- Notes/Risks: trust and price clarity matter more than dense filters in V1

### Search and filters
- Purpose: narrow artists by location, service type, availability, and price range
- Actor: customer
- Dependencies: discovery data, routing, search state, travel policy model
- Notes/Risks: do not overbuild advanced filtering before baseline discovery works

### Artist profile
- Purpose: help users evaluate artist fit
- Actor: customer
- Dependencies: artist entity, service packages, portfolio items, reviews summary, travel policy
- Notes/Risks: this is a trust screen, not just a data screen

### Package and service details
- Purpose: show what is included, duration, price, travel fees, and occasion fit
- Actor: customer
- Dependencies: service package domain, price presentation rules
- Notes/Risks: avoid ambiguous pricing language

### Booking flow
- Purpose: allow booking from artist/package selection through confirmation
- Actor: customer
- Dependencies: availability, address, booking pricing, checkout placeholder, booking repository
- Notes/Risks: booking state must be recoverable and auditable

### User bookings
- Purpose: let customers review upcoming and past bookings
- Actor: customer
- Dependencies: booking entity, status mapping, route details
- Notes/Risks: status labels must be explicit and localized

### Favorites
- Purpose: save artists for later consideration
- Actor: customer
- Dependencies: artist list/profile integration, account state
- Notes/Risks: low complexity but easy to overbuild

### Profile and settings
- Purpose: basic account control and preferences
- Actor: customer
- Dependencies: auth, user profile, localization settings later
- Notes/Risks: keep narrow in V1

## V1.5

### Artist onboarding
- Purpose: enable artists to join and configure public business presence
- Actor: artist
- Dependencies: role-aware auth, domain model, moderation assumptions
- Notes/Risks: introduces much more complexity than customer-only launch

### Artist availability management
- Purpose: define working windows, blackout periods, and booking acceptance
- Actor: artist
- Dependencies: availability domain, booking policies
- Notes/Risks: requires careful conflict logic

### Artist package management
- Purpose: create and update services, prices, add-ons, and duration
- Actor: artist
- Dependencies: service package domain, validation rules
- Notes/Risks: package sprawl can create poor UX without strong constraints

### Artist travel policy management
- Purpose: define radius, extra distance charges, and service area behavior
- Actor: artist
- Dependencies: address and distance strategy
- Notes/Risks: must remain transparent to customers

## Future

### Reviews and ratings authoring
- Purpose: increase trust and marketplace quality
- Actor: customer, platform
- Dependencies: completed bookings, moderation
- Notes/Risks: abuse and moderation concerns

### In-app chat and coordination
- Purpose: improve pre-appointment communication
- Actor: customer, artist
- Dependencies: identity, notifications, support policies
- Notes/Risks: operational burden rises quickly

### Promotions and referral systems
- Purpose: grow demand and retention
- Actor: customer, platform
- Dependencies: pricing engine, campaign logic
- Notes/Risks: defer until core booking conversion is healthy

### Platform admin tools
- Purpose: moderation, support, quality control
- Actor: admin/platform
- Dependencies: internal tooling strategy
- Notes/Risks: keep out of mobile app scope unless required

