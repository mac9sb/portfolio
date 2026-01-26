---
title: Tooling: Shared ecosystem
date: November 15, 2025
---

== Why the tools live together
The `tooling/` directory is where shared CLI and build utilities live. Keeping them together makes cross-tool coordination easier and encourages reuse.

== Shared libraries
Tools like WebUI and FluentGen are treated as products, not internal hacks. This keeps their APIs stable and encourages better documentation.

== Pattern to follow
If a tool solves a common problem in multiple projects, it belongs in tooling. It keeps the apps small and lets tools evolve independently.
