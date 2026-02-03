import Foundation
import Testing
import WebUI
import WebUIBrowserTesting

@testable import Portfolio

#if canImport(WebKit)

@Suite("Browser Smoke Tests", .serialized)
struct BrowserSmokeTests {
    @Test("Home page renders core sections")
    @MainActor
    func testHomePageContent() async throws {
        try await withPage(Home().body) { page in
            #expect(await page.getByRole(.main) != nil)
            #expect(await page.getByText("01 // IDENTITY") != nil)
            #expect(await page.getByText("02 // PROJECTS") != nil)
            #expect(await page.getByText("03 // LOGS") != nil)
        }
    }

    @Test("Logs list and article content")
    @MainActor
    func testLogsFlow() async throws {
        let log = try requireFirstLog()
        try await withPage(PageLayout { LogSection() }.body) { page in
            let logItems = await page.querySelectorAll(".log-item")
            #expect(logItems.count == logs.count)
            #expect(await page.getByText(log.title) != nil)
        }

        try await withPage(ArticlePage(log: log).body) { page in
            _ = try await page.waitForSelector(".markdown-content")
            #expect(await page.getByText("PUBLISHED // \(log.date)") != nil)
        }
    }

    @Test("Contact form flow")
    @MainActor
    func testContactForm() async throws {
        try await withPage(Contact().body) { page in
            try await page.fill("#contact-email", "test@example.com")
            try await page.fill("#contact-message", "Hello from the test suite.")
            try await page.click("button")

            let status: String? = try await page.evaluate("() => document.getElementById('contact-status')?.textContent")
            #expect(status?.contains("Thanks for reaching out") ?? false)
        }
    }
}

#endif
