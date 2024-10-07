import Foundation

struct CalendarRepoMock: CalendarRepo {
    func get() async throws -> [CalendarItem] {
        []
    }
}
