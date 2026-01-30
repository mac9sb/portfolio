---
title: Example: WebUI card composition
date: November 21, 2025
---

## Type-safe HTML generation

WebUI uses Swift's type system to generate valid HTML at compile time:

```html
<!-- Traditional HTML template (error-prone) -->
<div class="card">
  <h2>Hardcoded Title</h2>
  <p>Hardcoded description.</p>
</div>
```
```swift
// WebUI approach (type-safe)
Card {
    Heading(.h2, title)
    Text(description)
}
```
