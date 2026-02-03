import Foundation
import Testing
import WebUI
import WebUIBrowserTesting

@testable import Portfolio

@Suite("Portfolio Browser Tests", .serialized)
struct PortfolioBrowserTests {
    @Test("Home page renders projects and logs")
    @MainActor
    func testHomePageProjectAndLogCounts() async throws {
        try await withPage(Home().body) { page in
            let projectItems = await page.querySelectorAll(".project-item")
            let logItems = await page.querySelectorAll(".log-item")

            #expect(projectItems.count == projects.count)
            #expect(logItems.count == logs.count)

            _ = try await page.waitForSelector(".pagination-counter-projects")
            _ = try await page.waitForSelector(".pagination-counter-logs")
        }
    }

    @Test("Contact form updates status on click")
    @MainActor
    func testContactFormClickUpdatesStatus() async throws {
        try await withPage(Contact().body) { page in
            try await page.fill("#contact-email", "test@example.com")
            try await page.fill("#contact-message", "Hello from tests.")
            try await page.click("button")

            let status: String? = try await page.evaluate("() => document.getElementById('contact-status')?.textContent")
            #expect(status?.contains("Thanks for reaching out") ?? false)
        }
    }

    @Test("Article page renders markdown content")
    @MainActor
    func testArticlePageRendersMarkdownContent() async throws {
        let log = try requireFirstLog()

        try await withPage(ArticlePage(log: log).body) { page in
            _ = try await page.waitForSelector(".markdown-content")
            let heading: String? = try await page.evaluate("() => document.querySelector('h1')?.textContent")
            let expectedTitle = log.title.replacingOccurrences(of: "**", with: "")
            #expect(heading?.contains(expectedTitle) ?? false)
        }
    }
}
