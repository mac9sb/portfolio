import Foundation
import WebUI
import WebUIMarkdown

/// Article page: responsible for lazily rendering Markdown content.
///
/// Markdown rendering is performed lazily during page rendering so `ArticlePage`
/// construction remains lightweight and consistent with other pages.
struct ArticlePage: Document {
    let log: LogEntry

    init(log: LogEntry) {
        self.log = log
    }

    // MARK: - Document conformance

    var metadata: Metadata {
        let cleanTitle = log.title.replacingOccurrences(of: "**", with: "")
        return Metadata(
            from: Application.baseMetadata,
            title: cleanTitle,
            description: "Article: \(cleanTitle)",
            type: .article
        )
    }

    var path: String? { "logs/\(log.slug)" }

    /// Page-level scripts (global actions).
    var scripts: [Script]? {
        [Script(src: "/js/portfolio-actions.js", attribute: .defer)]
    }

    /// State machines used by article pages (e.g. copy buttons).
    var stateMachineSpecs: [String: StateMachine]? {
        nil
    }

    // MARK: - Markdown Rendering

    /// Lazily render Markdown content for this article.
    private var renderedResult: WebUIMarkdown.ParsedMarkdown? {
        guard
            let contentURL = Bundle.module.url(
                forResource: log.slug,
                withExtension: "md",
                subdirectory: "Content"
            ),
            let content = try? String(contentsOf: contentURL, encoding: .utf8)
        else {
            return nil
        }
        return Self.markdownRenderer().parseMarkdownSafely(content)
    }

    /// Article-scoped Markdown renderer with syntax highlighting enabled.
    static func markdownRenderer() -> WebUIMarkdown {
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
            // Base content styles
            .allHeadings { style in
                style.font(family: "'Space Grotesk'", weight: .semibold)
                style.color("#111817").onDark("#ffffff")
                style.margins(top: "2.5rem", bottom: "1rem")
            }
            .heading(.h1) { style in
                style.font(size: .extraLarge)
            }
            .heading(.h2) { style in
                style.font(size: .large)
            }
            .heading(.h3) { style in
                style.font(size: .body)
            }
            .paragraph { style in
                style.margins(bottom: "1rem")
            }
            // Inline code
            .inlineCode { style in
                style.font(family: "ui-monospace, SFMono-Regular, monospace", size: .footnote)
                style.color("#14b8aa")
                style.background("#e5e7eb").onDark("#1f2937")
                style.padding(vertical: "0.2em", horizontal: "0.4em")
                style.border(radius: "0.25rem")
            }
            // Code blocks
            .codeBlock { style in
                style.background("#f3f4f6").onDark("#1f2937")
                style.padding(all: "1rem")
                style.border(radius: "0.5rem")
                style.margins(bottom: "1.5rem")
            }
            // Blockquotes
            .blockquote { style in
                style.color("#4b5563").onDark("#9ca3af")
                style.padding(left: "1.5rem")
                style.border(width: "0 0 0 3px", style: "solid", color: "#14b8aa")
                style.margins(vertical: "1.5rem", horizontal: "0")
            }
            // Links
            .link { style in
                style.color("#14b8aa")
            }
            // Lists
            .orderedList { style in
                style.padding(left: "1.5rem")
                style.margins(bottom: "1rem")
            }
            .unorderedList { style in
                style.padding(left: "1.5rem")
                style.margins(bottom: "1rem")
            }
            .listItem { style in
                style.margins(bottom: "0.75rem")
            }
            // Tables
            .table { style in
                style.margins(vertical: "1rem", horizontal: "0")
            }
            .tableHeader { style in
                style.font(weight: .semibold)
                style.background("#f3f4f6").onDark("#1f2937")
                style.padding(vertical: "0.5rem", horizontal: "0.75rem")
                style.border(width: "1px", style: "solid", color: "#e5e7eb")
                style.borderColor("#e5e7eb").onDark("#374151")
            }
            .tableCell { style in
                style.padding(vertical: "0.5rem", horizontal: "0.75rem")
                style.border(width: "1px", style: "solid", color: "#e5e7eb")
                style.borderColor("#e5e7eb").onDark("#374151")
            }
            // Syntax highlighting
            .syntaxHighlighting { syntax in
                syntax.keyword("#14b8aa")
                syntax.string("#fca5a5")
                syntax.comment("#6b7280")
                syntax.number("#60a5fa")
                syntax.function("#14b8aa")
                syntax.type("#f472b6")
            }

        return WebUIMarkdown(options: options, typography: typography)
    }

    // MARK: - Body

    var body: some Markup {
        PageLayout {
            ArticleContent(log: log, renderedHTML: renderedResult?.htmlContent)
        }
    }
}

/// Article content element built with WebUI markup.
struct ArticleContent: Element {
    let log: LogEntry
    let renderedHTML: String?

    init(log: LogEntry, renderedHTML: String?) {
        self.log = log
        self.renderedHTML = renderedHTML
    }

    var body: some Markup {
        let (mainTitle, subtitle) = splitTitle(log.title)

        return Stack {
            Stack {
                Heading(.largeTitle, mainTitle)
                    .font(size: .xl3, weight: .bold)
                    .frame(maxWidth: .xl4)
                    .margins(of: 4, at: .bottom)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(size: .lg, weight: .medium, color: .gray(._600))
                        .margins(of: 1, at: .top)
                }
            }

            Stack {
                Text(log.category)
                    .font(size: .sm, weight: .semibold, color: .teal(._700))
                Text("PUBLISHED // \(log.date)")
                    .font(size: .xs, color: .gray(._500))
            }
            .margins(of: 3, at: .bottom)

            if let html = renderedHTML {
                Stack {
                    if let first = html.extractFirstParagraph() {
                        Text(first)
                            .font(leading: .relaxed)
                            .margins(of: 3, at: .bottom)
                    }
                    MarkupString(content: "<div class=\"markdown-content\">\(html)</div>")
                }
            } else {
                Text("Coming soon — this article is currently being written. Check back later for the full content.")
                    .font(leading: .relaxed)
                    .margins(of: 3, at: .top)
            }
        }
    }

    private func splitTitle(_ raw: String) -> (String, String?) {
        let clean = raw.replacingOccurrences(of: "**", with: "")
        let components = clean.components(separatedBy: ": ")
        let main = components.first?.trimmingCharacters(in: .whitespaces) ?? clean
        let subtitle = components.dropFirst().first?.trimmingCharacters(in: .whitespaces)
        return (main, subtitle)
    }
}

extension String {
    func extractFirstParagraph() -> String? {
        guard let range = self.range(of: "<p[^>]*>(.*?)</p>", options: .regularExpression, range: self.startIndex..<self.endIndex) else {
            return nil
        }
        let paragraphHTML = String(self[range])
        let textContent = paragraphHTML.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        return textContent.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func removeFirstParagraph() -> String {
        guard let range = self.range(of: "<p[^>]*>(.*?)</p>", options: .regularExpression, range: self.startIndex..<self.endIndex) else {
            return self
        }
        return self.replacingCharacters(in: range, with: "")
    }
}
