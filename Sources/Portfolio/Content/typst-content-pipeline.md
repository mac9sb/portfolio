---
title: Typst: Content pipeline and conventions
date: December 8, 2025
---

## Why Typst for content
Typst keeps authoring lightweight while still being structured. It is fast to iterate on, which matters when writing frequently and tuning the site design.

## Content conventions
Posts use front matter for title and date, then clear sectioning with `==` headings. This keeps rendering predictable and avoids heavy markdown glue.

## Integration pattern
Content files live next to site sources, making it easy for the site generator to transform them without extra tooling.

## Tip for consistency
Treat headings as the information architecture for the post. If the outline reads well, the page usually reads well too.
