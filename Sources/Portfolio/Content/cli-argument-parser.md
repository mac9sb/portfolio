---
title: Building CLI tools with ArgumentParser
date: November 15, 2023
---

# Building CLI Tools with ArgumentParser

Swift's ArgumentParser library makes building command-line tools straightforward and type-safe. This guide covers everything from basic commands to advanced patterns.

## Getting Started

Add ArgumentParser to your package:

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0")
]
```

## Basic Command

A simple command with arguments:

```swift
import ArgumentParser

@main
struct Greet: ParsableCommand {
    @Argument(help: "The name to greet")
    var name: String

    @Option(name: .shortAndLong, help: "Number of times to greet")
    var count: Int = 1

    @Flag(name: .shortAndLong, help: "Use formal greeting")
    var formal: Bool = false

    func run() throws {
        let greeting = formal ? "Good day" : "Hello"
        for _ in 0..<count {
            print("\(greeting), \(name)!")
        }
    }
}
```

Usage:
```bash
$ greet World --count 3
Hello, World!
Hello, World!
Hello, World!

$ greet "Dr. Smith" --formal
Good day, Dr. Smith!
```

## Subcommands

Organizing complex CLIs with subcommands:

```swift
@main
struct TodoCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "todo",
        abstract: "A task management tool",
        subcommands: [Add.self, List.self, Complete.self],
        defaultSubcommand: List.self
    )
}

extension TodoCLI {
    struct Add: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Add a new task"
        )

        @Argument(help: "Task description")
        var description: String

        @Option(name: .shortAndLong, help: "Priority level")
        var priority: Priority = .medium

        func run() throws {
            try TaskManager.add(description, priority: priority)
            print("Task added successfully")
        }
    }

    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "List all tasks"
        )

        @Flag(name: .shortAndLong, help: "Show completed tasks")
        var all: Bool = false

        func run() throws {
            let tasks = try TaskManager.list(includeCompleted: all)
            for task in tasks {
                print(task.formatted())
            }
        }
    }
}
```

## Custom Types

ArgumentParser works with custom types:

```swift
enum Priority: String, ExpressibleByArgument, CaseIterable {
    case low, medium, high, urgent

    static var allValueStrings: [String] {
        allCases.map { $0.rawValue }
    }
}

struct DateArgument: ExpressibleByArgument {
    let date: Date

    init?(argument: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: argument) else {
            return nil
        }
        self.date = date
    }
}
```

## Validation

Custom validation logic:

```swift
struct CreateUser: ParsableCommand {
    @Option(help: "User email")
    var email: String

    @Option(help: "User age")
    var age: Int

    func validate() throws {
        guard email.contains("@") else {
            throw ValidationError("Invalid email format")
        }
        guard age >= 13 else {
            throw ValidationError("Users must be at least 13 years old")
        }
    }
}
```

## Async Commands

Support for async/await:

```swift
struct FetchData: AsyncParsableCommand {
    @Option(help: "API endpoint")
    var endpoint: String

    func run() async throws {
        let data = try await fetchFromAPI(endpoint)
        print(data.formatted())
    }
}
```

## Best Practices

1. **Use descriptive help text** for all arguments
2. **Provide sensible defaults** where possible
3. **Validate early** in the `validate()` method
4. **Structure with subcommands** for complex tools
5. **Follow Unix conventions** for options and flags

## Conclusion

ArgumentParser provides a robust foundation for building Swift CLI tools. Its type-safe approach catches errors at compile time and generates professional help text automatically.
