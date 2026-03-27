# Continuation Backlog

Ordered next passes after the current launch-preparation wave:

1. Customer account APIs
  - hook favorites, saved addresses, profile, and notification preferences to remote-backed repositories
  - preserve graceful guest gating and post-auth continuation

2. Discovery contract refinement and media hydration
   - split list/detail payloads if needed without changing presentation
   - improve partial remote hydration for portfolio and availability preview
   - confirm package and specialty contract stability

3. Artist portfolio/media upload baseline
   - connect portfolio item metadata to real media selection, upload, and stored references without overbuilding media infrastructure
   - keep artist profile and discovery media assumptions aligned

4. External-beta vendor hookup
  - connect notification delivery, analytics, and crash-reporting services to real platform or vendor implementations
  - keep environment flags and bootstrap behavior stable across dev, beta, and production targets

5. Release-content finalization
  - replace provisional legal and policy copy with reviewed final content
  - finalize App Store metadata, reviewer notes, and privacy disclosure details

6. Launch decision refresh
  - rerun the cutover checklist and go/no-go assessment after customer account APIs and vendor hookups land
  - downgrade the current public-launch no-go only when the blocker docs actually change
