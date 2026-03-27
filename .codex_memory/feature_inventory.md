# Feature Inventory

## V1 Core

### Customer onboarding and auth
- Purpose: identify users and support returning sessions
- Actor: customer
- Dependencies: auth provider, app shell, localization, basic profile model
- Notes/Risks: keep auth simple; avoid role-complexity too early
- Current status: implemented as a hybrid remote/local session foundation with guest mode, customer mode, artist mode, protected-action handoff, local restore, remote-capable sign-in/sign-up/session bootstrap, environment-gated dev shortcuts, and post-auth route continuation

### Discovery home
- Purpose: let users browse nearby or relevant artists quickly
- Actor: customer
- Dependencies: location strategy, search filters, artist listing model, design system
- Notes/Risks: trust and price clarity matter more than dense filters in V1
- Current status: implemented with hybrid remote/local discovery loading, occasion chips, featured artists, popular packages, and explicit loading/error handling

### Search and filters
- Purpose: narrow artists by location, service type, availability, and price range
- Actor: customer
- Dependencies: discovery data, routing, search state, travel policy model
- Notes/Risks: do not overbuild advanced filtering before baseline discovery works
- Current status: implemented with hybrid remote/local discovery reads, local query plus occasion filter state, results count, and explicit loading/error handling

### Artist profile
- Purpose: help users evaluate artist fit
- Actor: customer
- Dependencies: artist entity, service packages, portfolio items, reviews summary, travel policy
- Notes/Risks: this is a trust screen, not just a data screen
- Current status: implemented with hybrid remote/local profile reads, trust summary, portfolio preview, package cards, availability preview, travel clarity, and retry handling

### Package and service details
- Purpose: show what is included, duration, price, travel fees, and occasion fit
- Actor: customer
- Dependencies: service package domain, price presentation rules
- Notes/Risks: avoid ambiguous pricing language
- Current status: implemented as a reusable package card plus a package detail route

### Booking flow
- Purpose: allow booking from artist/package selection through confirmation
- Actor: customer
- Dependencies: availability, address, booking pricing, checkout placeholder, booking repository
- Notes/Risks: booking state must be recoverable and auditable
- Current status: implemented with a canonical booking draft controller, service selection, event details, date/time steps, location step, travel fee preview, review summary, async request-submission handoff, and hybrid remote/local marketplace request persistence

### User bookings
- Purpose: let customers review upcoming and past bookings
- Actor: customer
- Dependencies: booking entity, status mapping, route details
- Notes/Risks: status labels must be explicit and localized
- Current status: implemented with shared marketplace lifecycle mapping, upcoming/past tabs, request timeline visibility, live accepted/declined updates from artist actions, and hybrid remote/local customer bookings retrieval

### Favorites
- Purpose: save artists for later consideration
- Actor: customer
- Dependencies: artist list/profile integration, account state
- Notes/Risks: low complexity but easy to overbuild
- Current status: implemented with repository-backed local favorite toggles, favorites list presentation, artist-profile save/remove handoff, and guest gating for account-bound save actions

### Profile and settings
- Purpose: basic account control and preferences
- Actor: customer
- Dependencies: auth, user profile, localization settings later
- Notes/Risks: keep narrow in V1
- Current status: implemented as a customer account hub with repository-backed local profile/preferences persistence, saved addresses baseline, notification preferences routing, centralized help/policy entry points, dedicated privacy/terms/cancellation/booking-policy routes, new-account setup prompts, sign-out, and session-aware role switching into artist mode

## V1.5

### Artist onboarding
- Purpose: enable artists to join and configure public business presence
- Actor: artist
- Dependencies: role-aware auth, domain model, moderation assumptions
- Notes/Risks: introduces much more complexity than customer-only launch
- Current status: implemented as a repository-backed local onboarding foundation with profile, specialties, travel, packages, availability, and readiness summary inside the shared app

### Artist portfolio management
- Purpose: let artists present polished proof-of-work without bloating V1 into a full media CMS
- Actor: artist
- Dependencies: artist management repository, customer profile presentation, future media upload contract
- Notes/Risks: media upload and moderation are still separate concerns from metadata management
- Current status: implemented as a hybrid remote/local portfolio metadata manager with canonical repository methods, add/edit/remove flows, mutation-safe UI states, and media-reference placeholders kept behind the artist-management boundary

### Artist availability management
- Purpose: define working windows, blackout periods, and booking acceptance
- Actor: artist
- Dependencies: availability domain, booking policies
- Notes/Risks: requires careful conflict logic
- Current status: implemented as a hybrid remote/local weekly rule-based availability setup with day toggles, add/edit/remove window mutations, repository-backed saves, and mutation-safe loading states

### Artist package management
- Purpose: create and update services, prices, add-ons, and duration
- Actor: artist
- Dependencies: service package domain, validation rules
- Notes/Risks: package sprawl can create poor UX without strong constraints
- Current status: implemented as a hybrid remote/local package-management surface with create/edit flows, active/inactive mutation support, validation, and reusable customer-aligned package presentation

### Artist travel policy management
- Purpose: define radius, extra distance charges, and service area behavior
- Actor: artist
- Dependencies: address and distance strategy
- Notes/Risks: must remain transparent to customers
- Current status: implemented as a hybrid remote/local service-area and travel-policy setup with repository-backed save behavior, validation, and customer-aligned travel summary fields

### Artist dashboard and readiness
- Purpose: give artists one operational home for setup progress, booking visibility, and quick actions
- Actor: artist
- Dependencies: artist setup state, readiness rules, route integration
- Notes/Risks: must stay operational and lean, not drift into admin-console sprawl
- Current status: implemented as a shared-app artist shell home with repository-backed readiness progress, active-package and available-day summaries, pending/accepted booking visibility, and quick links to core setup surfaces

### Artist bookings overview
- Purpose: let artists review upcoming requests and completed work at a glance
- Actor: artist
- Dependencies: artist booking summary model, status mapping, settings/help handoff later
- Notes/Risks: do not pretend accept/decline, messaging, or payout flows exist yet
- Current status: implemented as a hybrid remote/local marketplace-backed requests/upcoming/past overview with accept/decline actions, shared lifecycle visibility, and async error/loading handling

### Marketplace booking lifecycle
- Purpose: connect customer request submission, artist response, and cross-role status visibility
- Actor: customer, artist
- Dependencies: booking draft state, session state, artist access, customer bookings mapping
- Notes/Risks: keep lifecycle canonical and avoid separate customer/artist status stores
- Current status: implemented through a canonical hybrid remote/local booking repository with shared booking records, pending/accepted/declined/cancelled/completed statuses, request timeline entries, customer cancellation, and artist response actions

### Guest exploration
- Purpose: let new users experience marketplace value before account creation
- Actor: guest
- Dependencies: session state, discovery routes, protected-action gating
- Notes/Risks: do not gate too early or create a parallel guest app
- Current status: implemented with guest entry, protected-action prompts, post-auth continuation context, and guest access to discovery and booking exploration before submission

### Artist settings
- Purpose: centralize business notifications, setup shortcuts, and trust/help entry points
- Actor: artist
- Dependencies: artist state, route map, support layer
- Notes/Risks: avoid splitting artist preferences across unrelated screens
- Current status: implemented as a lightweight settings foundation with role-aware notification preferences routing, sign-out, and shortcuts into profile and travel setup

### Repository-backed hybrid data foundation
- Purpose: prepare the product for real backend integration without changing current UX flows
- Actor: platform/engineering
- Dependencies: feature domain models, persistence adapters, config strategy, test coverage
- Notes/Risks: avoid DTO sprawl and avoid direct UI dependencies on seed data or storage
- Current status: implemented for session, customer account, marketplace bookings, artist management, and discovery reads; app config, result/failure boundaries, and a canonical HTTP API-client boundary now exist, with session, discovery, marketplace bookings, and artist-management mutations now in hybrid remote/local mode

### Release-readiness planning
- Purpose: turn the current architecture-ready app into an execution-ready integration and QA target
- Actor: platform/engineering
- Dependencies: route correctness, repository boundaries, environment safety, regression tests
- Notes/Risks: planning docs must reflect actual code readiness, not aspirational scope
- Current status: implemented with backend integration sequencing docs, API hookup priorities, release checklist, known-gap inventory, test strategy, and router-guard regression coverage

### Notification delivery and observability foundation
- Purpose: make beta behavior measurable and operationally visible without overbuilding production infrastructure too early
- Actor: platform/engineering
- Dependencies: app config, session state, booking lifecycle events, app bootstrap
- Notes/Risks: keep delivery/instrumentation behind core service boundaries and environment flags
- Current status: implemented with canonical notification-delivery, analytics, and crash-reporting services, session-aware notification readiness sync, booking and artist mutation event hooks, and app-level fatal error capture in `main.dart`

### Release-candidate support and policy surfaces
- Purpose: make help, trust, and legal guidance easy to find before wider beta or public release
- Actor: customer, artist, platform/operations
- Dependencies: route discoverability, localization, settings/support linkage
- Notes/Risks: structure can ship now, but final legal copy still needs review before public release
- Current status: implemented as a shared support hub plus dedicated privacy, terms, cancellation, and booking-policy surfaces linked from settings and booking detail

### Launch decision and cutover readiness
- Purpose: support a disciplined launch decision instead of relying on optimistic release assumptions
- Actor: platform/engineering, operations
- Dependencies: release docs, blocker tracking, cutover validation, route and flow stability
- Notes/Risks: this layer must stay brutally honest about what is not yet public-release ready
- Current status: implemented with launch triage, cutover checklist, launch-day runbook, blocker inventory, master checklist, and an explicit go/no-go assessment that currently recommends no-go for public launch and conditional go for controlled external beta

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
