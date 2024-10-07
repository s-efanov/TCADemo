import Foundation
import Dependencies

private enum SearchRepoKey: DependencyKey {
    static let liveValue: any SearchRepo = SearchRepoImpl()
    static let testValue: any SearchRepo = SearchRepoMock()
}

extension DependencyValues {
    var searchRepo: any SearchRepo {
        get { self[SearchRepoKey.self] }
        set { self[SearchRepoKey.self] = newValue }
    }
}
