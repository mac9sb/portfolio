import Foundation
import WebUI
import WebUIBrowserTesting

@testable import Portfolio

@MainActor
func withPage<M: Markup>(
    _ content: M,
    run test: (Page) async throws -> Void
) async throws {
    let browser = Browser()
    try await browser.launch()
    let page = try await browser.newPage()
    defer {
        Task { @MainActor in
            try? await browser.close()
        }
    }

    try await page.setContent(content)
    try await test(page)
}

func requireFirstLog() throws -> LogEntry {
    guard let log = logs.first else {
        throw PortfolioTestError.missingLogs
    }
    return log
}

enum PortfolioTestError: Error {
    case missingLogs
}
