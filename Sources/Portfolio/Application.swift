import Foundation
import WebUI

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
            "https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;800&display=swap"
        ]
    }

    public var head: String? {
        "<style>html, body { font-family: 'Space Grotesk'; }</style>"
    }

    public var routes: [any Document] {
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

    static func main() async throws {
        do {
            try Application().build()
            print("✓ Application built successfully.")
        } catch {
            print("⨉ Failed to build application: \(error)")
        }
    }
}
