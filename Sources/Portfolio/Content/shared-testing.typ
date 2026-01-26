---
title: Shared Package: Testing strategy
date: December 30, 2025
---

== Why tests live with shared code
Shared models and utilities power multiple targets. Tests in the shared module protect all platforms at once and keep regressions from leaking into apps or the web.

== What to test
Focus on model behavior, utility logic, and critical data transforms. These are the pieces most likely to cause wide impact.

== Practical advice
Keep tests small and deterministic. If a test needs a complex setup, consider whether the logic should move into a smaller, more testable unit.
