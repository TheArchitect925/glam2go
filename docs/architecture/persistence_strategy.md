# Persistence Strategy

## Current Persistence Scope
Local persistence is now used for the minimum product-critical state that should survive app restart:
- session state
- protected-action continuation context
- customer profile
- customer preferences
- favorites
- saved addresses
- shared marketplace booking lifecycle records
- artist setup and readiness state

## Current Storage Choice
Use `SharedPreferences` only as a lightweight local store for this phase.

Why:
- enough for current mock-to-real transition needs
- simple to test
- easy to replace behind repositories later
- avoids pretending offline-first complexity already exists

## Not Persisted Yet
- booking draft state
- search query and filters
- media assets
- analytics state
- payment state

These can be added later only when the user experience justifies the complexity.

## Serialization Rule
- repositories own DTO serialization
- domain models should not be rewritten into ad hoc storage maps throughout the app
- storage helpers should read/write one serialized payload per feature area where practical

## Future Upgrade Path
When backend integration starts:
1. keep local repositories as cache or fallback implementations if still useful
2. add remote data sources under the same feature
3. decide per feature whether local persistence remains source-of-truth, cache, or is removed
4. do not leak `SharedPreferences` access into application or presentation layers
