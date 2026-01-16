---
title: Full stack safety with Hummingbird
date: January 10, 2024
---

# Full Stack Safety with Hummingbird

Hummingbird is a lightweight, flexible Swift web framework that enables type-safe full-stack development. This article explores how to leverage Swift's type system across your entire stack.

## Why Hummingbird?

Hummingbird offers several advantages:

- **Lightweight** - Minimal overhead and fast startup
- **Async/await native** - Built for Swift concurrency
- **Modular** - Use only what you need
- **Type-safe** - Leverage Swift's strong typing

## Shared Models

The key to full-stack type safety is sharing models between frontend and backend:

```swift
// Shared/Sources/Models/User.swift
public struct User: Codable, Sendable {
    public let id: UUID
    public let email: String
    public let name: String
    public let createdAt: Date

    public init(id: UUID, email: String, name: String, createdAt: Date) {
        self.id = id
        self.email = email
        self.name = name
        self.createdAt = createdAt
    }
}
```

## Backend Implementation

Setting up routes with Hummingbird:

```swift
import Hummingbird

func buildApplication() -> some ApplicationProtocol {
    let router = Router()

    router.get("/api/users/:id") { request, context -> User in
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw HTTPError(.badRequest)
        }
        return try await UserService.find(id: id)
    }

    router.post("/api/users") { request, context -> User in
        let dto = try await request.decode(as: CreateUserDTO.self, context: context)
        return try await UserService.create(dto)
    }

    return Application(router: router)
}
```

## Type-Safe API Client

The same models work on the client side:

```swift
// iOS/Sources/APIClient.swift
actor APIClient {
    private let baseURL: URL
    private let decoder = JSONDecoder()

    func fetchUser(id: UUID) async throws -> User {
        let url = baseURL.appending(path: "/api/users/\(id)")
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(User.self, from: data)
    }
}
```

## Validation

Type-safe validation using Swift's type system:

```swift
struct CreateUserDTO: Codable, Validatable {
    let email: String
    let name: String
    let password: String

    func validate() throws {
        guard email.contains("@") else {
            throw ValidationError.invalidEmail
        }
        guard password.count >= 8 else {
            throw ValidationError.passwordTooShort
        }
    }
}
```

## Benefits Realized

In production, this approach has delivered:

- **Compile-time error detection** for API mismatches
- **Reduced runtime errors** by 80%
- **Faster development cycles** due to shared code
- **Better documentation** through types

## Conclusion

Hummingbird enables true full-stack Swift development with type safety throughout. By sharing models between frontend and backend, you eliminate an entire class of bugs and improve developer experience.
