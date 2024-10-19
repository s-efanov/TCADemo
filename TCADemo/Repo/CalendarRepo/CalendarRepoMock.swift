import Foundation

struct CalendarRepoMock: CalendarRepo {
    var result: Result<[CalendarItem], Error>
    
    func get() async throws -> [CalendarItem] {
        switch result {
        case let .success(success):
            return success
        case let .failure(failure):
            throw failure
        }
    }
}
