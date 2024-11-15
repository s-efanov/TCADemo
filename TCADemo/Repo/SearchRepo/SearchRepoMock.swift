import Foundation

struct SearchRepoMock: SearchRepo {
    var result: Result<[SearchItem], Error>
    
    func get(_ text: String) async throws -> [SearchItem] {
        switch result {
        case let .success(success):
            return success
        case let .failure(failure):
            throw failure
        }
    }
}
