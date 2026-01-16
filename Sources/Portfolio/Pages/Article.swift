import WebUI
import WebUIMarkdown

struct ArticlePage: Document {
    let log: LogEntry
    let markdownContent: String

    var metadata: Metadata {
        Metadata(
            from: PortfolioSite.baseMetadata,
            title: log.title,
            description: "Article: \(log.title)",
            type: .article
        )
    }

    var path: String? { "logs/\(log.slug)" }

    var body: some Markup {
        PageLayout {
            ArticleContent(log: log, markdownContent: markdownContent)
        }
    }
}

struct ArticleContent: Element {
    let log: LogEntry
    let markdownContent: String

    var body: some Markup {
        Article {
            Stack {
                Link(to: "/") {
                    Text("Back to Home")
                }
                .font(size: .xs2, weight: .bold, color: .custom("#0c8075"))
                .margins(of: 6, at: .bottom)

                Stack {
                    Text(log.date)
                        .font(size: .xs2, weight: .bold)
                        .opacity(60)

                    Heading(.largeTitle, log.title)
                        .font(size: .xl3, weight: .bold)
                        .margins(of: 4, at: .top)
                        .on {
                            $0.md {
                                $0.font(size: .xl4)
                            }
                        }
                }
                .margins(of: 8, at: .bottom)
                .padding(of: 6, at: .bottom)
                .border(of: 1, at: .bottom, color: .black())

                Stack {
                    renderMarkdown()
                }
            }
            .padding(of: 8)
            .on {
                $0.md {
                    $0.padding(of: 12)
                }
            }
        }
        .background(color: .custom("#f5f5f3"))
    }

    private func renderMarkdown() -> some Markup {
        let markdown = WebUIMarkdown()
        let result = markdown.parseMarkdownSafely(markdownContent)
        return Text(result.htmlContent)
    }
}
