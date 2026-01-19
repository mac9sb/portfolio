---
title: Creating Guest List: Digital Venue Management
date: January 18, 2025
---

Guest List is a full-stack Swift application for digital guest list management at concert and gig venues. Built with Hummingbird backend, WebUI frontend, and Fluent ORM, this system demonstrates modern Swift web development practices for real-world business applications.

== The Problem Guest List Solves

Traditional venue guest list management relies on paper lists, spreadsheets, and manual coordination. This leads to:
- **Lost or damaged lists** during busy events
- **Manual data entry errors** and duplicates
- **Poor communication** between door staff and organizers
- **No real-time visibility** into attendance and capacity
- **Inefficient check-in processes** causing long lines

== System Architecture

Guest List uses a clean separation between domain models, services, and API endpoints.

=== Domain Models

```swift
// Core business entities
struct Event {
    let id: UUID
    var venueID: UUID
    var name: String
    var startTime: Date
    var capacity: Int
    var status: EventStatus
}

struct GuestListEntry {
    let id: UUID
    var eventID: UUID
    var guestName: String
    var checkedIn: Bool
    var plusOnes: Int
}

enum EventStatus {
    case upcoming, live, ended, cancelled
}
```

=== Service Layer

Business logic is encapsulated in actor-based services:

```swift
actor EventService {
    let database: Database

    func createEvent(_ event: Event) async throws -> Event {
        let model = EventModel(from: event)
        try await model.save(on: database)
        return model.toEvent()
    }

    func checkInGuest(guestID: UUID, eventID: UUID) async throws -> GuestListEntry {
        // Validate capacity and business rules
        let event = try await getEvent(id: eventID)
        guard event.currentGuestCount < event.capacity else {
            throw GuestListError.eventAtCapacity
        }

        // Perform check-in transaction
        let entry = try await database.checkInGuest(guestID: guestID, eventID: eventID)
        return entry
    }
}
```

=== API Layer

Hummingbird provides type-safe REST endpoints:

```swift
struct EventController {
    let eventService: EventService

    func routes(_ router: Router) {
        router.post("/events") { request, context -> Event in
            let createDTO = try await request.decode(as: CreateEventDTO.self)
            try createDTO.validate()
            return try await eventService.createEvent(createDTO.toEvent())
        }

        router.post("/events/{eventID}/checkin") { request, context -> GuestListEntry in
            let eventID = try context.parameters.require("eventID", as: UUID.self)
            let checkInRequest = try await request.decode(as: CheckInRequest.self)

            return try await eventService.checkInGuest(
                guestID: checkInRequest.guestID,
                eventID: eventID
            )
        }
    }
}
```

== Real-Time Features

=== WebSocket Updates

Door staff see real-time updates as guests arrive:

```swift
actor NotificationService {
    private var connectedClients: [UUID: WebSocket] = [:]

    func subscribe(clientID: UUID, websocket: WebSocket) {
        connectedClients[clientID] = websocket
    }

    func broadcastCheckIn(_ entry: GuestListEntry, event: Event) async {
        let update = CheckInUpdate(
            guestName: entry.guestName,
            eventName: event.name,
            timestamp: Date()
        )

        for websocket in connectedClients.values {
            try? await websocket.send(update.jsonString)
        }
    }
}
```

=== Mobile Check-In App

iOS/macOS apps provide offline-capable check-in:

```swift
class CheckInViewModel: ObservableObject {
    @Published var currentEvent: Event?
    @Published var recentCheckIns: [GuestListEntry] = []

    func checkInGuest(name: String, plusOnes: Int) async {
        guard let eventID = currentEvent?.id else { return }

        do {
            let entry = try await apiClient.checkInGuest(
                name: name,
                plusOnes: plusOnes,
                eventID: eventID
            )
            recentCheckIns.insert(entry, at: 0)
        } catch {
            // Handle offline storage and sync later
            storeOfflineCheckIn(name: name, plusOnes: plusOnes)
        }
    }
}
```

== Concurrency Patterns

The application uses Swift's structured concurrency throughout:

```swift
func processBulkCheckIn(guestIDs: [UUID], eventID: UUID) async throws -> [GuestListEntry] {
    try await withThrowingTaskGroup(of: GuestListEntry.self) { group in
        for guestID in guestIDs {
            group.addTask {
                try await eventService.checkInGuest(guestID: guestID, eventID: eventID)
            }
        }

        var results: [GuestListEntry] = []
        for try await entry in group {
            results.append(entry)
        }
        return results
    }
}
```

== Type Safety Across Layers

FluentGen ensures type safety from domain models to database:

```swift
// Domain model defines the API contract
@FluentModel
struct Event {
    let id: UUID
    var venueID: UUID
    var name: String
    var startTime: Date
    var capacity: Int
    var status: EventStatus
}

// Generated database model
final class EventModel: Model {
    static let schema = "events"

    @ID(key: .id) var id: UUID?
    @Field(key: "venue_id") var venueID: UUID
    @Field(key: "name") var name: String
    @Field(key: "start_time") var startTime: Date
    @Field(key: "capacity") var capacity: Int
    @Field(key: "status") var status: String

    // Auto-generated conversion methods
    func toEvent() -> Event { /* ... */ }
    convenience init(from event: Event) { /* ... */ }
}
```

== Deployment and Scaling

=== Docker Deployment

```yaml
= docker-compose.yml
version: '3.8'
services:
  guest-list:
    image: guest-list:latest
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgres://user:pass@db:5432/guestlist
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      - POSTGRES_DB=guestlist
```

=== Health Monitoring

Built-in health checks ensure system reliability:

```swift
struct HealthController {
    func routes(_ router: Router) {
        router.get("/health") { request, context -> HealthStatus in
            let dbHealthy = await checkDatabaseConnection()
            let memoryUsage = getMemoryUsage()

            return HealthStatus(
                database: dbHealthy,
                memoryUsage: memoryUsage,
                timestamp: Date()
            )
        }
    }
}
```

== Why Swift for Web Applications?

Guest List demonstrates Swift's strengths in web development:

- **Type safety** prevents common web application bugs
- **Performance** comparable to Node.js with better memory safety
- **Unified language** across frontend, backend, and mobile clients
- **Modern concurrency** with structured concurrency and actors
- **Rich ecosystem** with Hummingbird, Fluent, and Vapor packages

== Business Impact

Guest List has been used successfully at multiple venues, providing:
- **60% faster check-in times** compared to paper lists
- **Real-time capacity monitoring** preventing overselling
- **Accurate attendance tracking** for business analytics
- **Mobile accessibility** for staff coordination

== Learn More

For the complete implementation with authentication, admin dashboard, and advanced features:

[🔗 View Guest List on GitHub](https://github.com/mac9sb/guest-list)

This project showcases how Swift can be used to build production-ready, type-safe web applications that solve real business problems in the events industry.
