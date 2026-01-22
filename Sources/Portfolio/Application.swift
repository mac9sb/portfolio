import Foundation
import WebUI
import WebUITypst

/// Main portfolio website application.
///
/// Generates a static portfolio site with blog posts, project listings, and
/// Typst-rendered content. Uses WebUI for type-safe HTML generation and
/// WebUITypst for rendering Typst content.
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
            "/styles/typst.css",
            "/styles/article.css",
        ]
    }

    public var scripts: [Script]? {
        [
            Script(src: "/scripts/typst.js", attribute: .defer)
        ]
    }

    public var routes: [any Document] {
        get throws {
            var pages: [any Document] = [Home()]

            for log in logs {
                let rendered = renderTypstContent(for: log.slug)
                pages.append(ArticlePage(log: log, renderedHTML: rendered))
            }
            return pages
        }
    }

    private let typst: WebUITypst

    /// Creates a new portfolio application instance.
    ///
    /// Initializes the Typst renderer with custom typography styling for
    /// consistent article rendering.
    public init() {
        let typography = TypstTypography()
            .withHeadings { heading in
                heading.fontFamily = "'Space Grotesk', sans-serif"
                heading.baseFontSize = "1.5rem"
                heading.fontWeight = "600"
                heading.color = "#111817"
                heading.darkColor = "#ffffff"
                heading.marginTop = "2.5rem"
                heading.marginBottom = "1rem"
            }
            .withParagraphs { paragraph in
                paragraph.marginBottom = "1.5rem"
                paragraph.lineHeight = "1.6"
                paragraph.color = "#111817"
                paragraph.darkColor = "#e5e7eb"
            }
            .withInlineCode { inlineCode in
                inlineCode.fontFamily = "ui-monospace, SFMono-Regular, monospace"
                inlineCode.backgroundColor = "#e5e7eb"
                inlineCode.darkBackgroundColor = "#1f2937"
                inlineCode.color = "#14b8aa"
                inlineCode.padding = "0.2em 0.4em"
                inlineCode.borderRadius = "0.25rem"
                inlineCode.fontSize = "0.875em"
            }
            .withBlockquotes { blockquote in
                blockquote.borderLeft = "3px solid #14b8aa"
                blockquote.paddingLeft = "1.5rem"
                blockquote.color = "#4b5563"
                blockquote.darkColor = "#9ca3af"
                blockquote.fontStyle = "italic"
            }
            .withLinks { link in
                link.color = "#14b8aa"
                link.darkColor = "#14b8aa"
                link.textDecoration = "none"
                link.hoverTextDecoration = "underline"
            }
            .withLists { list in
                list.paddingLeft = "1.5rem"
                list.itemMarginBottom = "0.75rem"
            }
            .withTables { table in
                table.borderColor = "#111817"
                table.darkBorderColor = "#111817"
                table.cellPadding = "0.75rem 1rem"
                table.headerBackgroundColor = "#111817"
                table.darkHeaderBackgroundColor = "#111817"
                table.headerColor = "#ffffff"
                table.darkHeaderColor = "#ffffff"
                table.headerFontWeight = "600"
            }
            .withSyntaxHighlighting { syntax in
                syntax.keyword = "#14b8aa"
                syntax.string = "#fca5a5"
                syntax.comment = "#6b7280"
                syntax.number = "#60a5fa"
                syntax.function = "#14b8aa"
                syntax.type = "#f472b6"
                syntax.operator = "#ffffff"
                syntax.property = "#14b8aa"
                syntax.variable = "#ffffff"
                syntax.punctuation = "#ffffff"
            }
            .withClassPrefix("typst-")

        self.typst = WebUITypst(typography: typography)
    }

    /// Renders Typst content for a given article slug.
    ///
    /// Loads the Typst source file and renders it to HTML using the configured
    /// Typst renderer.
    ///
    /// - Parameter slug: The article slug (filename without extension).
    /// - Returns: Rendered HTML content, or an error message if rendering fails.
    private func renderTypstContent(for slug: String) -> String {
        let contentPath = "Sources/Portfolio/Content/\(slug).typ"

        guard let content = try? String(contentsOfFile: contentPath, encoding: .utf8) else {
            return "<p>Coming Soon</p><p>This article is currently being written. Check back later for the full content.</p>"
        }

        do {
            let result = try typst.renderSync(content)
            return result.htmlContent
        } catch {
            return "<p>Error rendering content: \(error)</p>"
        }
    }

    /// Main entry point for building the static site.
    ///
    /// Generates Typst assets and builds the complete static website to the
    /// output directory.
    ///
    /// - Throws: An error if asset generation or site building fails.
    static func main() async throws {
        // Generate Typst assets
        let typst = Application().typst
        try typst.generateAssets(in: URL(filePath: "Public"))

        do {
            try Application().build()
            print("✓ Application built successfully.")
        } catch {
            print("⨉ Failed to build application: \(error)")
        }
    }
}
