---
title: WebUI: Declarative page architecture
date: November 27, 2025
---

## HTML by composition
WebUI favors a declarative approach where the page is a Swift type and the body returns markup. The win is immediate: type safety and composability without template drift.

## Structure that scales
Layout components live in `Components/Layout`, while page-level sections live in `Components/Section` and specific content blocks. This keeps the design system coherent as pages grow.

## Why this fits the repo
Static sites and server-rendered pages share the same mental model. The same components can be reused for both generation styles without rewriting templates.

## Quick insight
If a page feels too large, extract it into sections and test the sections in isolation. The code remains readable and the design stays consistent.
