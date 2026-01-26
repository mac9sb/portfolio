import Foundation

/// Represents a blog post or log entry in the portfolio.
///
/// Contains metadata about an article including its title, publication date,
/// URL slug, and category.
struct LogEntry: Sendable {
    let id: String
    let date: String
    let title: String
    let slug: String
    let category: String
}

let logs: [LogEntry] = [
    LogEntry(id: "1", date: "17.01.2026", title: "Testing in the Shared Package", slug: "shared-testing", category: "TESTING"),
    LogEntry(id: "2", date: "03.01.2026", title: "Release Automation with GitHub Workflows", slug: "release-automation", category: "TOOLING"),
    LogEntry(id: "3", date: "06.12.2025", title: "Static Site Layout Patterns", slug: "static-site-layout", category: "DESIGN"),
    LogEntry(id: "4", date: "08.11.2025", title: "The Shared Design System", slug: "shared-design-system", category: "DESIGN"),
    LogEntry(id: "5", date: "11.10.2025", title: "Validation Service Design", slug: "validation-service", category: "SERVER"),
    LogEntry(id: "6", date: "06.09.2025", title: "Redis Services as a Pattern", slug: "redis-services-pattern", category: "SERVER"),
    LogEntry(id: "7", date: "23.08.2025", title: "Middleware Patterns for the Server", slug: "server-middleware-patterns", category: "SERVER"),
    LogEntry(id: "8", date: "09.08.2025", title: "FluentGen Models in Practice", slug: "fluentgen-models", category: "TOOLING"),
    LogEntry(id: "9", date: "12.07.2025", title: "Typst Content Pipeline", slug: "typst-content-pipeline", category: "CONTENT"),
    LogEntry(id: "10", date: "21.06.2025", title: "The Tooling Ecosystem", slug: "tooling-ecosystem", category: "TOOLING"),
    LogEntry(id: "11", date: "07.06.2025", title: "WebUI and Declarative Pages", slug: "webui-declarative-pages", category: "DESIGN"),
    LogEntry(id: "12", date: "24.05.2025", title: "Configuration Patterns in Pkl", slug: "cli-config-patterns", category: "INFRA"),
    LogEntry(id: "13", date: "10.05.2025", title: "Hummingbird App Structure in the Monorepo", slug: "hummingbird-app-structure", category: "SERVER"),
    LogEntry(id: "14", date: "12.04.2025", title: "Arc CLI Workflows", slug: "arc-cli-workflows", category: "INFRA"),
    LogEntry(id: "15", date: "29.03.2025", title: "Arc Server Process Model", slug: "arc-server-process", category: "INFRA"),
]
