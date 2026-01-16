import Foundation
import WebUI

@main
struct PortfolioSite: Website {
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

    var metadata: Metadata { Self.baseMetadata }

    var stylesheets: [String]? {
        [
            "https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;800&display=swap"
        ]
    }

    var routes: [any Document] {
        get throws {
            var pages: [any Document] = [Home()]

            for log in logs {
                let content = loadMarkdownContent(for: log.slug)
                pages.append(ArticlePage(log: log, markdownContent: content))
            }

            return pages
        }
    }

    private func loadMarkdownContent(for slug: String) -> String {
        let contentPath = "Sources/Portfolio/Content/\(slug).md"

        if let content = try? String(contentsOfFile: contentPath, encoding: .utf8) {
            return content
        }

        return """
            # Coming Soon

            This article is currently being written. Check back later for the full content.
            """
    }

    static func main() throws {
        try PortfolioSite().build(to: URL(filePath: ".output"))
        print("Site built successfully to .output/")
    }
}
