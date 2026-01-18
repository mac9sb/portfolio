import Foundation

struct LogEntry: Sendable {
    let id: String
    let date: String
    let title: String
    let slug: String
}

let logs: [LogEntry] = [
    LogEntry(id: "1", date: "25.01.2025", title: "Building POCKET-PULSE: Embedded Swift Communication Device", slug: "pocket-pulse-embedded-device"),
    LogEntry(id: "2", date: "25.01.2025", title: "The Problem FLUENT-GEN Solves", slug: "fluent-gen-problem-solution"),
    LogEntry(id: "3", date: "25.01.2025", title: "Creating GUEST-LIST: Digital Venue Management", slug: "guest-list-venue-management"),
    LogEntry(id: "4", date: "25.01.2025", title: "Building WEB-UI: Type-Safe Website Generation", slug: "web-ui-type-safe-websites"),
    LogEntry(id: "5", date: "25.01.2025", title: "Recreating LIST: Modern File Listing Tool", slug: "list-modern-file-tool"),
]
