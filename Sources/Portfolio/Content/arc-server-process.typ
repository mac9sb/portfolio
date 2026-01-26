---
title: Arc Server: Process model and lifecycle
date: January 6, 2026
---

== Why a custom process manager?
Arc is the glue in this monorepo. It watches configuration changes, boots app and static targets, and keeps one mental model for local and production runs. The goal is simple: reliable services and a fast local loop.

== How it runs apps
Each app site declares a working directory and executable. Arc treats them as managed processes, with ports tracked by configuration instead of hand-maintained scripts. That keeps new services easy to add without extra runbooks.

== Hot reload flow
Arc watches `config.pkl` and reloads the graph on change. This keeps the developer loop tight and limits configuration drift between environments.

== What this enables
- consistent start/stop across apps and static sites
- one command to get everything running
- predictable health checks and status reporting

== Practical tip
Keep app build steps deterministic, then let Arc handle the lifecycle. You will spot misconfigurations earlier that way.
