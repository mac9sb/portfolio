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
        #expect(app.stylesheets?.contains("/styles/typst.css") == true)
    }
    
    @Test("Application has scripts")
    func testApplicationHasScripts() {
        let app = Application()
        #expect(app.scripts != nil)
        #expect(app.scripts?.contains { $0.src == "/scripts/typst.js" } == true)
    }
}
