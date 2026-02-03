import Foundation
import WebUI

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
            "https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;800&display=swap"
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

    /// Generates the Markdown CSS and writes it into Public/styles/markdown.css.
    private static func writeMarkdownCSS() throws {
        let css = ArticlePage.markdownRenderer().generateAdvancedCSS()
        let rootURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let stylesDir = rootURL.appending(path: "Public/styles", directoryHint: .isDirectory)
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: stylesDir.path, isDirectory: &isDirectory) {
            if !isDirectory.boolValue {
                throw NSError(
                    domain: "Portfolio",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Public/styles exists but is not a directory."]
                )
            }
        } else {
            try FileManager.default.createDirectory(
                at: stylesDir,
                withIntermediateDirectories: true
            )
        }
        let cssURL = stylesDir.appending(path: "markdown.css")
        try css.write(to: cssURL, atomically: true, encoding: .utf8)
    }

    /// Main entry point for building the static site.
    ///
    /// Builds the complete static website to the output directory with
    /// Markdown-rendered content.
    ///
    /// - Throws: An error if site building fails.
    static func main() async throws {
        do {
            try writeMarkdownCSS()
            try Application().build()
            print("✓ Application built successfully.")
        } catch {
            print("⨉ Failed to build application: \(error)")
        }
    }
}
