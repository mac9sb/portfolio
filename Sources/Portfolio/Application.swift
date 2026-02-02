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
    static let baseMetadata = Metadata(
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
            var pages: [any Document] = [Home(), Contact()]

            for log in logs {
                pages.append(ArticlePage(log: log))
            }
            return pages
        }
    }

    private let markdown: WebUIMarkdown

    /// Creates a new portfolio application instance.
    ///
    /// Initializes the Markdown renderer with enhanced features including
    /// syntax highlighting and table of contents generation.
    public init() {
        let options = MarkdownRenderingOptions(
            syntaxHighlighting: .enabledForAll,
            tableOfContents: .enabled(maxDepth: 3),
            codeBlocks: MarkdownRenderingOptions.CodeBlockOptions(
                copyButton: true,
                lineNumbers: false,
                showFileName: false
            )
        )
        let typography = MarkdownTypography(defaultFontSize: .body)
        self.markdown = WebUIMarkdown(options: options, typography: typography)
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
