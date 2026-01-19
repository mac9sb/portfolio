---
title: Building WebUI: Type-Safe Website Generation
date: January 18, 2025
---

WebUI is a Swift library for generating websites in a type-safe, consistent manner. It supports both Static Site Generation (SSG) and Server-Side Rendering (SSR) approaches, providing a modern alternative to traditional HTML templating.

== The Problem WebUI Solves

Traditional web development with HTML templates suffers from:
- **Runtime errors** from malformed HTML or invalid attributes
- **Inconsistent styling** across pages and components
- **Poor developer experience** with string concatenation
- **Limited type safety** in dynamic content rendering
- **Verbose boilerplate** for common UI patterns

== Type-Safe HTML Generation

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

== Core Concepts

=== Elements and Modifiers

Every HTML element is represented as a Swift type:

```swift
struct Card: Element {
    let title: String
    let description: String

    var body: some Markup {
        Div {
            Heading(.h2, title)
                .font(weight: .semibold)
                .margins(of: 4, at: .bottom)

            Text(description)
                .font(color: .stone(._600))
        }
        .padding(of: 6)
        .background(color: .white)
        .border(of: 1, at: .all, color: .stone(._200))
        .borderRadius(.lg)
        .shadow(.md)
    }
}
```

=== Responsive Design

Built-in responsive breakpoints make mobile-first design natural:

```swift
struct HeroSection: Element {
    var body: some Markup {
        Section {
            VStack {
                Heading(.h1, "Welcome")
                    .font(size: .xl6, weight: .bold)
                    .on {
                        $0.md { $0.font(size: .xl4) }  // Tablet
                        $0.sm { $0.font(size: .xl2) }  // Mobile
                    }

                Text("Build amazing websites with Swift")
                    .font(size: .lg)
                    .textAlign(.center)
                    .maxWidth(.xl3)
            }
        }
        .padding(of: 12)
        .on {
            $0.md { $0.padding(of: 8) }
            $0.sm { $0.padding(of: 4) }
        }
    }
}
```

== Static Site Generation

Generate complete websites at build time:

```swift
@main
struct MyWebsite: Website {
    var metadata: Metadata {
        Metadata(
            title: "My Website",
            description: "Built with WebUI"
        )
    }

    var routes: [any Document] {
        [
            HomePage(),
            AboutPage(),
            BlogIndex()
        ]
    }

    static func main() throws {
        try MyWebsite().build(to: URL(filePath: ".output"))
    }
}

struct HomePage: Document {
    var metadata: Metadata {
        Metadata(title: "Home")
    }

    var body: some Markup {
        HTML {
            Head {
                Title("My Website")
                Meta(charset: .utf8)
                Link(rel: .stylesheet, href: "/styles.css")
            }

            Body {
                Header { /* Navigation */ }
                Main { /* Page content */ }
                Footer { /* Footer content */ }
            }
        }
    }
}
```

== Server-Side Rendering

Render pages dynamically on the server:

```swift
// Hummingbird integration
func blogRoutes(_ router: Router) {
    router.get("/blog/:slug") { request, context -> HTMLResponse in
        let slug = try context.parameters.require("slug", as: String.self)

        guard let post = try await blogService.getPost(slug: slug) else {
            throw HTTPError(.notFound)
        }

        let page = BlogPostPage(post: post)
        return try HTMLResponse(page.render())
    }
}

struct BlogPostPage: Element {
    let post: BlogPost

    var body: some Markup {
        Article {
            Header {
                Heading(.h1, post.title)
                Time(post.publishDate.formatted())
            }

            Section {
                // Render markdown content
                MarkdownContent(post.content)
            }
        }
    }
}
```

== Component Composition

Build complex UIs from reusable components:

```swift
struct BlogCard: Element {
    let post: BlogPost

    var body: some Markup {
        Link(href: "/blog/\(post.slug)") {
            VStack(spacing: 3) {
                Heading(.h3, post.title)
                    .font(weight: .semibold)
                    .lineClamp(2)

                Text(post.excerpt)
                    .font(size: .sm, color: .stone(._600))
                    .lineClamp(3)

                HStack {
                    Text(post.author)
                    Spacer()
                    Time(post.publishDate.formatted(date: .abbreviated, time: .omitted))
                }
                .font(size: .xs, color: .stone(._500))
            }
        }
        .textDecoration(.none)
        .hover {
            $0.shadow(.lg)
            $0.transform(.translateY(-2))
        }
    }
}

// Usage in a grid layout
struct BlogGrid: Element {
    let posts: [BlogPost]

    var body: some Markup {
        Grid(columns: 3, spacing: 6) {
            ForEach(posts) { post in
                BlogCard(post: post)
            }
        }
        .on {
            $0.md { $0.columns(2) }  // Tablet: 2 columns
            $0.sm { $0.columns(1) }  // Mobile: 1 column
        }
    }
}
```

== CSS Generation

WebUI can generate optimized CSS alongside HTML:

```swift
struct AppStyles {
    static let global = CSS {
        FontFace("Inter", url: "/fonts/inter.woff2")

        Selector.universal {
            BoxSizing(.borderBox)
            Margin(0)
            Padding(0)
        }

        Selector("body") {
            FontFamily("Inter", .sansSerif)
            FontSize(.base)
            LineHeight(1.6)
            Color(.stone(._900))
        }
    }

    static let components = CSS {
        // Button styles
        Selector(".btn") {
            Display(.inlineBlock)
            Padding(.rem(0.75), .rem(1.5))
            BackgroundColor(.blue(._500))
            Color(.white)
            BorderRadius(.md)
            Border(.none)
            Cursor(.pointer)
            Transition(.all, duration: .ms(200))

            Hover {
                BackgroundColor(.blue(._600))
                Transform(.translateY(.px(-1)))
            }
        }
    }
}
```

== Why Swift for Web Development?

WebUI demonstrates several advantages of using Swift for web development:

=== Type Safety
- **Compile-time validation** of HTML structure and attributes
- **No runtime HTML errors** from malformed markup
- **Strong typing** for component props and state

=== Developer Experience
- **IntelliSense** and autocomplete for all HTML/CSS properties
- **Refactoring safety** - rename a component and all usages update
- **Modern language features** - enums, generics, protocols

=== Performance
- **Zero runtime overhead** for static generation
- **Optimized CSS** with automatic deduplication
- **Tree-shaking** removes unused styles automatically

=== Consistency
- **Design system enforcement** through types
- **Responsive design** built into the component API
- **Accessibility** features built-in (ARIA attributes, semantic HTML)

== Real-World Usage

WebUI powers this portfolio site and has been used in production applications. It provides:
- **50% less code** compared to traditional HTML templating
- **Zero HTML validation errors** in generated output
- **Consistent design** across all pages and components
- **Easy maintenance** through type-safe refactoring

== Learn More

For comprehensive documentation, component library, and examples:

[🔗 View WebUI on GitHub](https://github.com/mac9sb/web-ui)

WebUI transforms web development from error-prone string manipulation into a type-safe, maintainable coding experience that leverages Swift's powerful language features.
