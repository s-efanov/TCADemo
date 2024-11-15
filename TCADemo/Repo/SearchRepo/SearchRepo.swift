import Foundation

protocol SearchRepo {
    func get(_ text: String) async throws -> [SearchItem]
}

struct SearchItem: Codable, Hashable {
    let title: String
    let type: String
}

struct SearchResponse: Codable, Hashable {
    let search: [SearchItem]
}
