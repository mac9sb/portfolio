---
title: FluentGen: Macro-driven models in practice
date: December 4, 2025
---

## Macro-driven models
The `@FluentModel` macro keeps model definitions concise. The model stays focused on structure, while FluentGen handles the boilerplate.

## Benefits
- fewer manual schema definitions
- consistent mapping between Swift and the database
- easier changes when fields evolve

## Where it shines
For shared models like users, tickets, and venues, the macro keeps the data layer consistent across services. That matters more as the monorepo grows.

## Recommendation
Keep models minimal and let services express behavior. Models should be data; services should be logic.
