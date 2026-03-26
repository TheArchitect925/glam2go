# Engineering Guardrails

## Build Rules
- do not add routes without updating route docs
- do not add user-facing strings without localization intent
- do not create duplicate components or pages
- do not create alternate architecture tracks
- do not let shared folders become catch-all storage

## Scope Rules
- align implementation to `docs/product/v1_scope.md`
- move future ideas to `docs/product/future_scope.md`
- do not smuggle future features into V1 under vague names

## Quality Rules
- small, reviewable passes
- meaningful names
- tests added when logic becomes non-trivial
- avoid premature abstractions

## Documentation Rules
- update docs and memory in the same pass as architectural change
- final report must call out any remaining drift or unresolved decisions

## Cleanup Rules
- remove obvious starter/demo code when replaced
- do not leave temporary files or abandoned scaffolds behind
- generated artifacts are not source of truth

