# Localization Strategy

## Principle
All user-facing text should be localization-ready from the start.

## Baseline Direction
- use Flutter `gen-l10n`
- create a single app localization entrypoint under `lib/app`
- name strings by feature and intent, not by raw widget names

## Rules
- no hardcoded user-facing strings in production widgets once localization is introduced
- empty, loading, error, form labels, button text, and status labels all count
- route titles and bottom navigation labels must also be localized

## Practical Guidance
- establish localization early, before real screen count grows
- keep copy keys stable and readable
- avoid dumping every string into generic buckets like `commonTitle1`

