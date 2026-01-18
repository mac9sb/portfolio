import WebUI
import WebUIMarkdown

struct ArticlePage: Document {
    let log: LogEntry
    let markdownContent: String

    var metadata: Metadata {
        Metadata(
            from: Application.baseMetadata,
            title: log.title,
            description: "Article: \(log.title)",
            type: .article
        )
    }

    var path: String? { "logs/\(log.slug)" }

    var head: String? {
        "<style>\(ArticleContent.generateArticleStyles())</style>"
    }

    var body: some Markup {
        PageLayout {
            ArticleContent(log: log, markdownContent: markdownContent)
        }
    }
}

struct ArticleContent: Element {
    let log: LogEntry
    let markdownContent: String

    /// Generates the article CSS styles (light mode, matching site theme)
    static func generateArticleStyles() -> String {
        """
        /* Article Styles - Light Mode */
        .article-container {
            background-color: #fafaf9;
            position: relative;
        }

        .article-header {
            border-bottom: 1px solid #000;
            position: relative;
        }

        .article-date {
            color: #71717a;
            letter-spacing: 0.1em;
            text-transform: uppercase;
        }

        .article-title {
            color: #000;
        }

        .back-link {
            color: #0c8075;
            text-decoration: none;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-link::before {
            content: '←';
            transition: transform 0.2s ease;
        }

        .back-link:hover {
            color: #0a6b62;
        }

        .back-link:hover::before {
            transform: translateX(-4px);
        }

        /* Markdown Content Styles */
        .markdown-content {
            color: #1c1917;
            line-height: 1.8;
            font-size: 1.1rem;
        }

        .markdown-content h1,
        .markdown-content h2,
        .markdown-content h3,
        .markdown-content h4 {
            color: #000;
            margin-top: 2.5rem;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .markdown-content h2 {
            font-size: 1.75rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #e7e5e4;
        }

        .markdown-content h3 {
            font-size: 1.35rem;
        }

        .markdown-content p {
            margin-bottom: 1.5rem;
        }

        .markdown-content a {
            color: #0c8075;
            text-decoration: none;
            border-bottom: 1px solid rgba(12, 128, 117, 0.3);
            transition: all 0.2s ease;
        }

        .markdown-content a:hover {
            color: #0a6b62;
            border-bottom-color: #0a6b62;
        }

        .markdown-content strong {
            color: #000;
            font-weight: 600;
        }

        .markdown-content em {
            font-style: italic;
        }

        .markdown-content code {
            background: #f5f5f4;
            color: #0c8075;
            padding: 0.2em 0.4em;
            border-radius: 4px;
            font-family: 'JetBrains Mono', 'SF Mono', monospace;
            font-size: 0.9em;
            border: 1px solid #e7e5e4;
        }

        .markdown-content pre {
            background: #1c1917;
            border: 1px solid #000;
            border-radius: 8px;
            padding: 1.5rem;
            overflow-x: auto;
            margin: 1.5rem 0;
        }

        .markdown-content pre code {
            background: none;
            border: none;
            padding: 0;
            color: #fafaf9;
            font-size: 0.9rem;
            line-height: 1.6;
        }

        .markdown-content blockquote {
            border-left: 3px solid #0c8075;
            background: #f5f5f4;
            padding: 1rem 1.5rem;
            margin: 1.5rem 0;
            border-radius: 0 8px 8px 0;
            font-style: italic;
            color: #44403c;
        }

        .markdown-content ul,
        .markdown-content ol {
            margin: 1.5rem 0;
            padding-left: 1.5rem;
        }

        .markdown-content li {
            margin-bottom: 0.75rem;
        }

        .markdown-content ul li::marker {
            color: #0c8075;
        }

        .markdown-content ol li::marker {
            color: #0c8075;
        }

        .markdown-content hr {
            border: none;
            height: 1px;
            background: #e7e5e4;
            margin: 2.5rem 0;
        }

        .markdown-content img {
            max-width: 100%;
            border-radius: 8px;
            border: 1px solid #e7e5e4;
        }

        .markdown-content table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
        }

        .markdown-content th,
        .markdown-content td {
            padding: 0.75rem 1rem;
            border: 1px solid #e7e5e4;
            text-align: left;
        }

        .markdown-content th {
            background: #f5f5f4;
            color: #000;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.05em;
        }

        .markdown-content tr:nth-child(even) {
            background: #fafaf9;
        }

        /* Article content max width and centering */
        .markdown-content {
            max-width: 680px;
            margin-left: auto;
            margin-right: auto;
        }

        .article-header {
            max-width: 680px;
            margin-left: auto;
            margin-right: auto;
        }

        .back-link {
            display: block;
            max-width: 680px;
            margin-left: auto;
            margin-right: auto;
        }



        /* Dark Mode Styles */
        @media (prefers-color-scheme: dark) {
            .article-container {
                background-color: #1c1917;
            }

            .article-header {
                border-bottom-color: #fafaf9;
            }

            .article-date {
                color: #a1a1aa;
            }

            .article-title {
                color: #fafaf9;
            }

            .back-link {
                color: #2dd4bf;
            }

            .back-link:hover {
                color: #5eead4;
            }

            .markdown-content {
                color: #e7e5e4;
            }

            .markdown-content h1,
            .markdown-content h2,
            .markdown-content h3,
            .markdown-content h4 {
                color: #fafaf9;
            }

            .markdown-content h2 {
                border-bottom-color: #44403c;
            }

            .markdown-content a {
                color: #2dd4bf;
                border-bottom-color: rgba(45, 212, 191, 0.3);
            }

            .markdown-content a:hover {
                color: #5eead4;
                border-bottom-color: #5eead4;
            }

            .markdown-content strong {
                color: #fafaf9;
            }

            .markdown-content code {
                background: #292524;
                color: #2dd4bf;
                border-color: #44403c;
            }

            .markdown-content blockquote {
                background: #292524;
                border-left-color: #2dd4bf;
                color: #a8a29e;
            }

            .markdown-content hr {
                background: #44403c;
            }

            .markdown-content img {
                border-color: #44403c;
            }

            .markdown-content th,
            .markdown-content td {
                border-color: #44403c;
            }

            .markdown-content th {
                background: #292524;
                color: #fafaf9;
            }

            .markdown-content tr:nth-child(even) {
                background: #1c1917;
            }
        }
        """
    }

    var body: some Markup {
        Article {


            Stack {
                Link(to: "/") {
                    Text("Back to Home")
                }
                .addClass("back-link")
                .margins(of: 6, at: .bottom)

                Stack {
                    Text(log.date)
                        .addClass("article-date")
                        .font(size: .xs2, weight: .bold)

                    Heading(.largeTitle, log.title)
                        .addClass("article-title")
                        .font(size: .xl3, weight: .bold)
                        .margins(of: 4, at: .top)
                        .on {
                            $0.md {
                                $0.font(size: .xl4)
                            }
                        }
                }
                .addClass("article-header")
                .margins(of: 8, at: .bottom)
                .padding(of: 6, at: .bottom)

                Stack {
                    renderMarkdown()
                }
                .addClass("markdown-content")
            }
            .padding(of: 8)
            .on {
                $0.md {
                    $0.padding(of: 12)
                }
            }
        }
        .addClass("article-container")
    }

    private func renderMarkdown() -> some Markup {
        let markdown = WebUIMarkdown()
        let result = markdown.parseMarkdownSafely(markdownContent)
        // Use MarkupString to render raw HTML without escaping
        return MarkupString(content: result.htmlContent)
    }
}
