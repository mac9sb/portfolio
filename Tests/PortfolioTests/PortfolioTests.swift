import Foundation
import Testing

@testable import Portfolio

@Suite("Portfolio Tests")
struct PortfolioTests {
    @Test("Application initializes")
    func testApplicationInitializes() {
        let app = Application()
        #expect(app.metadata.site == "Mac Long")
    }

    @Test("Application has routes")
    func testApplicationHasRoutes() throws {
        let app = Application()
        let routes = try app.routes
        #expect(!routes.isEmpty)
    }

    @Test("Application has stylesheets")
    func testApplicationHasStylesheets() {
        let app = Application()
        #expect(app.stylesheets != nil)
        #expect(app.stylesheets?.contains("https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;800&display=swap") == true)
        #expect(app.stylesheets?.contains("/public/styles/markdown.css") == false)
        #expect(app.stylesheets?.contains("/public/styles/article.css") == false)
    }

    @Test("Article page has stylesheets")
    func testArticlePageHasStylesheets() {
        let log = logs.first ?? LogEntry(id: "test", date: "01.01.2026", title: "Test Article", slug: "test-article", category: "TEST")
        let page = ArticlePage(log: log)
        #expect(page.stylesheets?.contains("/public/styles/markdown.css") == true)
        #expect(page.stylesheets?.contains("/public/styles/article.css") == true)
    }

    @Test("Application has scripts")
    func testApplicationHasScripts() {
        let app = Application()
        #expect(app.scripts == nil)
    }
}
