import Foundation

protocol CalendarRepo {
    func get() async throws -> [CalendarItem]
}

struct CalendarItem: Codable, Hashable {
    let title: String
    let from: String
    let to: String
}

struct CalendarResponse: Codable, Hashable {
    let events: [CalendarItem]
}
