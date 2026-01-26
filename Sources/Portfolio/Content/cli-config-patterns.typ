---
title: Configuration: Reusable patterns in Pkl
date: December 22, 2025
---

== Why Pkl fits here
Pkl makes configuration expressive and type-safe. It works well for a monorepo with many subprojects and shared concerns.

== Composition over duplication
Sites in `config.pkl` amend a base `ArcConfiguration.pkl`, so shared defaults live in one place. New sites only provide what is unique.

== Practical tip
Keep environment-specific details localized. It keeps local runs close to production without burying env logic in every site.
