import Foundation

struct SearchRepoMock: SearchRepo {
    func get() async throws -> [SearchItem] {
        []
    }
}
