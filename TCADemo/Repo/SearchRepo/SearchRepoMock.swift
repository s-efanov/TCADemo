import Foundation

struct SearchRepoMock: SearchRepo {
    var result: Result<[SearchItem], Error>
    
    func get() async throws -> [SearchItem] {
        switch result {
        case let .success(success):
            return success
        case let .failure(failure):
            throw failure
        }
    }
}
