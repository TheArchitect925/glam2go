# State Management Strategy

## Baseline Choice
Use Riverpod as the single primary state-management approach.

## Why
- clear dependency injection
- testable providers and controllers
- good fit for async booking and discovery state
- scales from simple screens to richer flows without introducing multiple patterns

## State Rules
- UI-only ephemeral state can stay local to widgets when trivial
- feature state and async orchestration belong in feature application layers
- shared app state belongs in app or core providers only when truly cross-cutting
- avoid provider sprawl by naming providers around business intent

## Avoid
- mixing Riverpod with unrelated global singleton patterns
- putting repository logic in widgets
- keeping booking flow logic in ad hoc mutable local state across multiple screens

