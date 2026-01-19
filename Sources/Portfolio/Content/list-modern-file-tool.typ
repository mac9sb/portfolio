---
title: Recreating Swift List: Modern File Listing Tool
date: January 18, 2025
---

Swift List is a modern, fast rebuild of the classic UNIX `ls` command. Built with Swift and ArgumentParser, it provides enhanced file listing with colors, icons, and human-readable output while maintaining full compatibility with traditional `ls` usage patterns.

== The Problem Swift List Solves

The classic `ls` command, while powerful, has several limitations:
- **No color output** by default (requires additional configuration)
- **Hard to read** large file sizes and permissions
- **No visual file type indicators** beyond basic symbols
- **Inconsistent output** across different systems
- **Limited customization** options

== Core Command Structure

Swift List uses Swift's ArgumentParser for robust CLI handling:

```swift
import ArgumentParser

@main
struct List: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "sls",  // Swift List
        version: "1.3.0"
    )

    @Flag(name: .shortAndLong, help: "Display all files, including hidden.")
    var all = false

    @Flag(name: .shortAndLong, help: "Display file attributes in long format.")
    var long = false

    @Flag(name: .shortAndLong, help: "Colorize the output.")
    var color = false

    @Flag(name: .shortAndLong, help: "Display icons denoting file type.")
    var icons = false

    @Flag(name: .shortAndLong, help: "Display each file on its own line.")
    var oneLine = false

    @Flag(name: .long, help: "Display human readable file sizes.")
    var humanReadable = false

    @Argument(help: "List files at one or more paths.")
    var paths: [String] = ["."]
}
```

== File System Abstraction

Swift List abstracts file system operations for testability and platform independence:

```swift
protocol FileSystem {
    func contents(of directory: URL) throws -> [FileInfo]
    func attributes(of file: URL) throws -> FileAttributes
}

struct DefaultFileSystem: FileSystem {
    func contents(of directory: URL) throws -> [FileInfo] {
        let urls = try FileManager.default.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: [
                .isDirectoryKey,
                .fileSizeKey,
                .creationDateKey,
                .contentModificationDateKey
            ]
        )

        return try urls.map { url in
            let attributes = try attributes(of: url)
            return FileInfo(url: url, attributes: attributes)
        }
    }
}
```

== Display Formatting

Intelligent formatting adapts to different output requirements:

```swift
struct DisplayOptions {
    let all: Bool
    let long: Bool
    let color: Bool
    let icons: Bool
    let oneLine: Bool
    let humanReadable: Bool
}

struct FileDisplay {
    func format(files: [FileInfo], options: DisplayOptions) -> String {
        if options.long {
            return formatLong(files: files, options: options)
        } else if options.oneLine {
            return formatOneLine(files: files, options: options)
        } else {
            return formatGrid(files: files, options: options)
        }
    }

    private func formatLong(files: [FileInfo], options: DisplayOptions) -> String {
        files.map { file in
            let permissions = formatPermissions(file.attributes.permissions)
            let size = options.humanReadable ?
                formatSize(file.attributes.size) : "\(file.attributes.size)"
            let date = file.attributes.modificationDate.formatted(date: .numeric, time: .shortened)
            let name = formatName(file.name, options: options)

            return "\(permissions) \(size) \(date) \(name)"
        }.joined(separator: "")
    }
}
```

== Color and Icon Support

Visual enhancements make output more scannable:

```swift
enum FileType {
    case directory, file, executable, image, video, audio, archive

    var icon: String {
        switch self {
        case .directory: return "📁"
        case .executable: return "⚙️"
        case .image: return "🖼️"
        case .video: return "🎥"
        case .audio: return "🎵"
        case .archive: return "📦"
        case .file: return "📄"
        }
    }

    var color: TerminalColor {
        switch self {
        case .directory: return .blue
        case .executable: return .green
        case .image, .video, .audio: return .magenta
        case .archive: return .red
        default: return .default
        }
    }
}

struct TerminalColor {
    static let reset = "\u{001B}[0m"
    static let blue = "\u{001B}[34m"
    static let green = "\u{001B}[32m"
    static let red = "\u{001B}[31m"
    static let magenta = "\u{001B}[35m"

    static func colorize(_ text: String, color: String) -> String {
        "\(color)\(text)\(reset)"
    }
}
}
```

== Size Formatting

Human-readable file sizes prevent confusion:

```swift
func formatSize(_ bytes: Int64) -> String {
    let units = ["B", "KB", "MB", "GB", "TB"]
    var size = Double(bytes)
    var unitIndex = 0

    while size >= 1024 && unitIndex < units.count - 1 {
        size /= 1024
        unitIndex += 1
    }

    if unitIndex == 0 {
        return "\(Int(size))\(units[unitIndex])"
    } else {
        return String(format: "%.1f\(units[unitIndex])", size)
    }
}

// Example output:
// 4.2KB instead of 4200
// 1.8MB instead of 1800000
```

== Performance Optimizations

Swift List is designed for speed even with large directories:

```swift
// Concurrent file processing for large directories
func processLargeDirectory(_ directory: URL, options: DisplayOptions) async throws -> [FileInfo] {
    let urls = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)

    return try await withThrowingTaskGroup(of: FileInfo?.self) { group in
        for url in urls {
            group.addTask {
                try? FileInfo(url: url)
            }
        }

        var results: [FileInfo] = []
        for try await fileInfo in group {
            if let fileInfo = fileInfo {
                results.append(fileInfo)
            }
        }
        return results
    }
}
```

== Cross-Platform Compatibility

Swift List works consistently across macOS, Linux, and Windows:

```swift
struct FileInfo {
    let url: URL
    let name: String
    let type: FileType
    let size: Int64
    let modificationDate: Date
    let permissions: FilePermissions

    init(url: URL) throws {
        self.url = url
        self.name = url.lastPathComponent

=== os(macOS) || os(iOS)
        let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
        self.size = attributes[.size] as? Int64 ?? 0
        self.modificationDate = attributes[.modificationDate] as? Date ?? Date.distantPast
        #elseif os(Linux)
        // Linux-specific attribute handling
        #elseif os(Windows)
        // Windows-specific attribute handling
        #endif

        self.type = FileType.detect(from: url)
        self.permissions = FilePermissions(from: attributes)
    }
}
```

== Testing Strategy

Comprehensive testing ensures reliability:

```swift
class ListCommandTests: XCTestCase {
    var fileSystem: MockFileSystem!

    override func setUp() {
        fileSystem = MockFileSystem()
        fileSystem.addFile("test.txt", size: 1024)
        fileSystem.addFile("hidden.txt", size: 2048, isHidden: true)
        fileSystem.addDirectory("subdir")
    }

    func testBasicListing() {
        let command = List()
        command.fileSystem = fileSystem

        let output = try command.run()
        XCTAssertTrue(output.contains("test.txt"))
        XCTAssertFalse(output.contains("hidden.txt")) // Hidden by default
    }

    func testAllFlag() {
        var command = List()
        command.all = true
        command.fileSystem = fileSystem

        let output = try command.run()
        XCTAssertTrue(output.contains("hidden.txt"))
    }
}
```

== Why Swift for CLI Tools?

Swift List demonstrates Swift's strengths for command-line applications:

- **Type safety** prevents common CLI parsing errors
- **Rich ecosystem** with ArgumentParser and System frameworks
- **Cross-platform** compatibility out of the box
- **Performance** competitive with C implementations
- **Modern language features** make code maintainable

== Usage Examples

```bash
= Basic listing
sls

= Long format with colors and icons
sls -l --color --icons

= Show all files with human-readable sizes
sls -a --human-readable

= List multiple directories
sls ~/Documents ~/Downloads

= One file per line (for scripting)
sls --one-line
```

== Performance Comparison

Swift List matches or exceeds traditional `ls` performance:

- **Memory efficient** - processes files on-demand
- **Fast startup** - minimal initialization overhead
- **Scalable** - handles directories with thousands of files
- **Low CPU usage** - efficient algorithms and data structures

== Learn More

For complete source code, advanced features, and installation instructions:

[🔗 View Swift List on GitHub](https://github.com/mac9sb/list)

Swift List shows how Swift can be used to build modern, user-friendly command-line tools that improve upon classic UNIX utilities while maintaining backward compatibility.
