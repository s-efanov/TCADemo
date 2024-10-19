import Foundation
import Dependencies

private enum CalendarRepoKey: DependencyKey {
    static let liveValue: any CalendarRepo = CalendarRepoImpl()
}

extension DependencyValues {
    var calendarRepo: any CalendarRepo {
        get { self[CalendarRepoKey.self] }
        set { self[CalendarRepoKey.self] = newValue }
    }
}
