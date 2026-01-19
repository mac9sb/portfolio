import Foundation

struct LogEntry: Sendable {
    let id: String
    let date: String
    let title: String
    let slug: String
    let category: String
}

let logs: [LogEntry] = [
    LogEntry(id: "1", date: "25.01.2025", title: "Designing FluentGen: Swift ORM Code Generation Macro", slug: "fluent-gen-problem-solution", category: "TOOLING"),
    LogEntry(id: "2", date: "25.01.2025", title: "Creating Guest List: Digital Venue Management", slug: "guest-list-venue-management", category: "APPLICATION"),
    LogEntry(id: "3", date: "25.01.2025", title: "Building WebUI: Type-Safe Website Generation", slug: "web-ui-type-safe-websites", category: "TOOLING"),
    LogEntry(id: "4", date: "25.01.2025", title: "Recreating Swift List: Modern File Listing Tool", slug: "list-modern-file-tool", category: "TOOLING"),
]
