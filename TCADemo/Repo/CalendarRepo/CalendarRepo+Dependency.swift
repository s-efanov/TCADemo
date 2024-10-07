import Foundation
import Dependencies

private enum CalendarRepoKey: DependencyKey {
    static let liveValue: any CalendarRepo = CalendarRepoImpl()
    static let testValue: any CalendarRepo = CalendarRepoMock()
}

extension DependencyValues {
    var calendarRepo: any CalendarRepo {
        get { self[CalendarRepoKey.self] }
        set { self[CalendarRepoKey.self] = newValue }
    }
}
