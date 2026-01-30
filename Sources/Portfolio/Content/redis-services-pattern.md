---
title: Redis Services: Protocol-first pattern
date: December 18, 2025
---

## Service interface first
Redis services are modeled behind a protocol, with both real and in-memory implementations. This keeps production behavior intact while enabling fast local testing.

## Why the split matters
An in-memory adapter speeds up tests and local workflows. The production adapter can focus on performance and reliability without complicating the rest of the codebase.

## Pattern to reuse
When building new services, define a protocol and at least one test-friendly implementation. It keeps dependencies flexible and reduces friction in unit tests.
