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

## Before Creating A New File
- Confirm the responsibility does not already exist.
- Confirm the file belongs to the approved architecture.
- Confirm the route, scope, and naming are already documented or update the docs first.

## Before Replacing Existing Code
- Audit what the current file already does.
- Preserve useful logic and naming when possible.
- If a rewrite is truly necessary, document why in the final report.
