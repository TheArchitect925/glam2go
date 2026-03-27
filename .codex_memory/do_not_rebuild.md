# Do Not Rebuild

Use this file as a blunt filter before creating code.

## Stop These Anti-Patterns
- Do not create a second page because the first page feels messy. Clean or extend the existing page.
- Do not create a duplicate route for the same experience.
- Do not hardcode user-facing strings when localization exists or is about to exist.
- Do not introduce a one-off component variant when a shared component should be extended.
- Do not add undocumented state-management patterns.
- Do not build giant god-widgets that mix routing, async state, layout, domain mapping, and form logic.
- Do not leave temporary files, scratch widgets, or abandoned scaffolds in the repo.
- Do not build features without updating docs and memory when assumptions changed.
- Do not create `new_`, `temp_`, `final_`, `copy_`, or `v2` files as an escape hatch.
- Do not rebuild a flow from scratch without auditing the current implementation first.
- Do not edit generated localization files by hand; treat `lib/l10n/app_localizations*.dart` as generated output.
- Do not treat `build/` output as source code or project memory.
- Do not scatter mock marketplace data across screens; extend the canonical feature-owned mock catalog until real repositories replace it.
- Do not create a second booking state source. The booking draft controller is the canonical in-session flow state.
- Do not create separate account mock stores for bookings, favorites, profile, or addresses. The account providers under `lib/features/profile/application` are the current canonical customer-account state layer.
- Do not create a separate artist-only app architecture, shell system, or mock store tree. Artist-side setup lives inside the same shared app and currently flows through `lib/features/artist_management/application`.
- Do not create a parallel guest app or route tree. Guest access must stay inside the same router and session model as customer and artist flows.
- Do not create separate customer-side and artist-side booking status sources. Marketplace booking lifecycle is now shared state.
- Do not create a second auth/session continuation store. Pending protected actions, sign-in resumes, and role switching belong to the canonical session layer.
- Do not add widget-local sign-in shortcuts that bypass the session controller. Even dev-default accounts must flow through the same auth hooks and continuation logic.
- Do not hardcode page-level colors, gradients, radii, or shadows in screens when the design-system tokens already define them.
- Do not create a second tag, chip, hero-card, or button style when the shared primitive can be extended.
- Do not let providers or widgets import local storage adapters directly. Storage belongs behind a feature repository.
- Do not deserialize raw maps inside controllers or screens. DTO mapping belongs in data-layer mappers or repository implementations.
- Do not add a remote data source directly to UI code. Remote calls must be introduced behind the existing repository contracts.
- Do not maintain separate “mock repository” and “real repository” trees that drift. Keep one canonical repository contract per feature and swap implementations cleanly.
- Do not instantiate HTTP or API clients inside features. Remote transport must flow through the canonical core network provider layer.
- Do not instantiate analytics, crash-reporting, or notification-delivery SDKs directly in widgets or feature providers. Those integrations belong behind canonical core service boundaries.
- Do not leave development-only shortcuts enabled by default in non-development environments.
- Do not make async remote providers block unrelated local flows when a stable repository-backed snapshot fallback is already the intended hybrid behavior.
- Do not let hybrid remote repositories silently re-seed local mock data into remote-backed caches during mutation paths.
- Do not overwrite a just-saved artist mutation with an immediate stale remote reload. Merge the saved state locally first, then refresh opportunistically.

## Before Creating A New File
- Confirm the responsibility does not already exist.
- Confirm the file belongs to the approved architecture.
- Confirm the route, scope, and naming are already documented or update the docs first.

## Before Replacing Existing Code
- Audit what the current file already does.
- Preserve useful logic and naming when possible.
- If a rewrite is truly necessary, document why in the final report.
