import WebUI
import WebUITypst

struct ArticlePage: Document {
    let log: LogEntry
    let renderedHTML: String

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

    var body: some Markup {
        PageLayout {
            ArticleContent(log: log, renderedHTML: renderedHTML)
        }
    }
}

struct ArticleContent: Element {
    let log: LogEntry
    let renderedHTML: String

    var body: some Markup {
        MarkupString(content: buildArticleHTML())
    }

    private func buildArticleHTML() -> String {
        let cleanTitle = self.log.title.replacingOccurrences(of: "**", with: "")
        let titleComponents = cleanTitle.components(separatedBy: ": ") // Use ": " for splitting
        let mainTitle = titleComponents.first?.trimmingCharacters(in: .whitespaces) ?? cleanTitle
        let subtitle = titleComponents.dropFirst().first?.trimmingCharacters(in: .whitespaces)

        var html = """
        <div class="article-container">
            <div class="article-header-section">
                <h1 class="article-header-title">
                    \(mainTitle)
        """
        if let subtitle = subtitle {
            html += "<br/><span class=\"article-header-subtitle\">\(subtitle)</span>"
        }
        html += """
                </h1>
            </div>

            <div class="article-meta-info">
                <span class="article-category">\(self.log.category)</span>
                <span class="article-published">PUBLISHED // \(self.log.date)</span>
            </div>

        """

        var remainingHTML = self.renderedHTML
        if let firstParagraph = remainingHTML.extractFirstParagraph() {
            html += "<p class=\"article-intro-paragraph\">\(firstParagraph)</p>\n"
            remainingHTML = remainingHTML.removeFirstParagraph()
        }

        html += """
            \(remainingHTML)
        </div>
        <script>
        (function() {
            const copyButtons = document.querySelectorAll('.typst-copy-btn');
            copyButtons.forEach(function(btn) {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const wrapper = this.closest('.typst-code-wrapper');
                    if (!wrapper) return;
                    
                    const codeLines = wrapper.querySelectorAll('.typst-code-line code');
                    let text = '';
                    codeLines.forEach(function(line, index) {
                        text += line.textContent;
                        if (index < codeLines.length - 1) text += '\\n';
                    });
                    
                    navigator.clipboard.writeText(text).then(function() {
                        const originalHTML = btn.innerHTML;
                        btn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>';
                        setTimeout(function() {
                            btn.innerHTML = originalHTML;
                        }, 2000);
                    }).catch(function(err) {
                        console.error('Copy failed:', err);
                    });
                });
            });
        })();
        </script>
        """
        return html
    }
}

extension String {
    func extractFirstParagraph() -> String? {
        guard let range = self.range(of: "<p[^>]*>(.*?)</p>", options: .regularExpression, range: self.startIndex..<self.endIndex) else { return nil }
        let paragraphHTML = String(self[range])
        let textContent = paragraphHTML.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        return textContent.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func removeFirstParagraph() -> String {
        guard let range = self.range(of: "<p[^>]*>(.*?)</p>", options: .regularExpression, range: self.startIndex..<self.endIndex) else { return self }
        return self.replacingCharacters(in: range, with: "")
    }
}
