import Foundation
import Testing

import WebUIBrowserTesting

#if canImport(WebKit)

@Suite("Browser Smoke Tests")
struct BrowserSmokeTests {
    @Test("Home page renders core sections")
    func testHomePageContent() async throws {
        let plan = BrowserTest("Home Page") {
            Navigate(to: "https://maclong.dev")

            AssertView {
                MainContent()
                Navigation()
                Footer()

                Heading("Swift engineer experienced in web services, cli tools, embedded and native apple applications.")
                Text("01 // IDENTITY")
                Text("02 // PROJECTS")
                Text("03 // LOGS")
                Text("Static Site Layout Patterns")
            }
        }

        try await plan.run()
    }

    @Test("Logs index and article content")
    func testLogsFlow() async throws {
        let plan = BrowserTest("Logs Flow") {
            Navigate(to: "https://maclong.dev/logs")

            AssertView {
                Heading("Index of /logs")
                List()
                ListItem("static-site-layout.html")
                Link("static-site-layout.html").hover()
                Link("static-site-layout.html").tap()
            }

            Navigate(to: "https://maclong.dev/logs/static-site-layout.html")

            AssertView {
                MainContent()
                Heading("Static Site Layout Patterns")
                Text("PUBLISHED // 06.12.2025")
                Footer()
            }
        }

        try await plan.run()
    }

    @Test("Contact form flow")
    func testContactForm() async throws {
        let plan = BrowserTest("Contact Form") {
            Navigate(to: "https://maclong.dev/contact")

            AssertView {
                MainContent()
                Heading("Contact")
                Text("Use the form below to send an email.")
                Text("Ready to send.")
                TextField("Email").fill("test@example.com")
                TextField("Message").fill("Hello from the test suite.")
                Button("Send Message").tap()
            }

            AssertView {
                Text("Thanks for reaching out. I will reply soon.")
            }
        }

        try await plan.run()
    }
}

#endif
