---
title: Arc CLI: Daily workflows and commands
date: January 12, 2026
---

== The CLI as a daily driver
The Arc CLI sits between configuration and runtime. It stays small on purpose: a handful of verbs you can rely on across projects.

== Common commands
- `arc run` starts the full graph in the foreground
- `arc run --background` keeps services running after the terminal closes
- `arc status` reports health across managed targets
- `arc stop` shuts down everything cleanly

== Why this matters
When local commands mirror production behavior, you catch problems earlier. Adding a new app or static site does not require a new playbook.

== Pattern to follow
Define the site in configuration, build once, and let Arc own the lifecycle. If a project needs a special flow, wrap it as a build step instead of a custom runner.
