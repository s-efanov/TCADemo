import Foundation
import Dependencies

private enum SearchRepoKey: DependencyKey {
    static let liveValue: any SearchRepo = SearchRepoImpl()
}

extension DependencyValues {
    var searchRepo: any SearchRepo {
        get { self[SearchRepoKey.self] }
        set { self[SearchRepoKey.self] = newValue }
    }
}
