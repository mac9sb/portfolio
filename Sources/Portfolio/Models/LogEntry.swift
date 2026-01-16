import Foundation

struct LogEntry: Sendable {
    let id: String
    let date: String
    let title: String
    let slug: String
}

let logs: [LogEntry] = [
    LogEntry(id: "1", date: "24.03.2025", title: "Optimizing Swift performance on ARM", slug: "optimizing-swift-arm"),
    LogEntry(id: "2", date: "24.02.2025", title: "Embedded Swift in industrial environments", slug: "embedded-swift-industrial"),
    LogEntry(id: "3", date: "24.01.2026", title: "Full stack safety with Hummingbird", slug: "full-stack-hummingbird"),
    LogEntry(id: "4", date: "23.12.2025", title: "Concurrency patterns in Swift 5.10", slug: "concurrency-swift-5-10"),
    LogEntry(id: "5", date: "21.11.2025", title: "Building CLI tools with ArgumentParser", slug: "cli-argument-parser"),
]
