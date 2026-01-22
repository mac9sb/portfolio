import Foundation

/// Represents a project showcased in the portfolio.
///
/// Contains project metadata including title, description, and GitHub URL
/// for display on the portfolio website.
struct Project: Sendable {
    let id: String
    let title: String
    let description: String
    let url: String
}

let projects: [Project] = [
    Project(
        id: "2",
        title: "FLUENT-GEN",
        description: "A Swift macro package that automatically generates Fluent ORM model classes from simple domain model structs.",
        url: "https://github.com/mac9sb/fluent-gen"
    ),
    Project(
        id: "3",
        title: "GUEST-LIST",
        description: "A full-stack Swift application for digital guest list management at concert and gig venues with Hummingbird backend.",
        url: "https://github.com/mac9sb/guest-list"
    ),
    Project(
        id: "4",
        title: "WEB-UI",
        description: "A library for generating websites in a simple, type-safe, and consistent manner. Supports SSG and SSR approaches.",
        url: "https://github.com/mac9sb/web-ui"
    ),
    Project(
        id: "5",
        title: "LIST",
        description: "A simple and fast rebuild of the UNIX ls command. Provides color output, file icons, and human-readable sizes.",
        url: "https://github.com/mac9sb/list"
    ),
]
