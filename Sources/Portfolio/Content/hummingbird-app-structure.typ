---
title: Hummingbird: App structure and request flow
date: November 29, 2025
---

== One app, one Web package
Each server app lives under `apps/<name>/Web`. This keeps Swift package boundaries clean and lets you build or test a single service without touching others.

== Request flow essentials
The Web target owns routing, middleware, and handlers. Shared models and utilities live in the `Shared` package so app code can stay focused on HTTP concerns.

== Middleware as composition
Hummingbird works well with explicit middleware layers. Authentication, validation, and logging stay as composable steps instead of living inside handlers.

== Takeaway
Keep app packages small and push shared concerns into the shared module. This keeps compile times reasonable and reduces cross-service coupling.
