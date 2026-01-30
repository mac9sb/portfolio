import Foundation
import WebUI
import WebUIMarkdown

/// Main portfolio website application.
///
/// Generates a static portfolio site with blog posts, project listings, and
/// Markdown-rendered content. Uses WebUI for type-safe HTML generation and
/// WebUIMarkdown for rendering Markdown content.
@main
public struct Application: Website {
    nonisolated(unsafe) static let baseMetadata = Metadata(
        site: "Mac Long",
        title: "Welcome",
        titleSeparator: " | ",
        description: "Full Stack Swift specialising in Web Services, CLI Tools, Embedded and Native Apple Applications.",
        author: "Mac Long",
        keywords: ["Swift", "SwiftUI", "Hummingbird", "iOS", "macOS", "Full Stack", "POSIX", "UNIX"],
        locale: .en,
        type: .website,
    )

    public var metadata: Metadata { Self.baseMetadata }

    public var stylesheets: [String]? {
        [
            "https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;800&display=swap",
            "/styles/markdown.css",
            "/styles/article.css",
        ]
    }

    public var scripts: [Script]? {
        nil
    }

    public var routes: [any Document] {
        get throws {
            var pages: [any Document] = [Home()]

            for log in logs {
                let rendered = renderMarkdownContent(for: log.slug)
                pages.append(ArticlePage(log: log, renderedHTML: rendered))
            }
            return pages
        }
    }

    private let markdown: EnhancedMarkdownRenderer

    /// Creates a new portfolio application instance.
    ///
    /// Initializes the Markdown renderer with enhanced features including
    /// syntax highlighting and table of contents generation.
    public init() {
        self.markdown = EnhancedMarkdownRenderer(
            enableSyntaxHighlighting: true,
            enableTableOfContents: true,
            syntaxTheme: .dracula
        )
    }

    /// Renders Markdown content for a given article slug.
    ///
    /// Loads the Markdown source file and renders it to HTML using the configured
    /// Markdown renderer with syntax highlighting and enhanced features.
    ///
    /// - Parameter slug: The article slug (filename without extension).
    /// - Returns: Rendered HTML content, or an error message if rendering fails.
    private func renderMarkdownContent(for slug: String) -> String {
        let contentPath = "Sources/Portfolio/Content/\(slug).md"

        guard let content = try? String(contentsOfFile: contentPath, encoding: .utf8) else {
            return "<p>Coming Soon</p><p>This article is currently being written. Check back later for the full content.</p>"
        }

        do {
            let html = try markdown.render(content)
            return html
        } catch {
            return "<p>Error rendering content: \(error)</p>"
        }
    }

    /// Main entry point for building the static site.
    ///
    /// Builds the complete static website to the output directory with
    /// Markdown-rendered content.
    ///
    /// - Throws: An error if site building fails.
    static func main() async throws {
        do {
            try Application().build()
            print("✓ Application built successfully.")
        } catch {
            print("⨉ Failed to build application: \(error)")
        }
    }
}
