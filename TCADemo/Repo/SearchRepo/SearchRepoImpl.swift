import Dependencies
import Foundation

struct SearchRepoImpl: SearchRepo {
    func get(_ text: String) async throws -> [SearchItem] {
        try decode(data: try await request())
    }
    
    func decode(data: Data) throws -> [SearchItem] {
        var str = String(data: data, encoding: .utf8)!
        str = str.replacingOccurrences(of: "\n", with: "", options: .literal)
        
        do {
            let response = try JSONDecoder().decode(SearchResponse.self, from: str.data(using: .utf8)!)
            return response.search
        } catch {
            throw NetworkError(error: error)
        }
    }
    
    func request() async throws -> Data {
        try await URLSession(configuration: .ephemeral).data(from: URL(
            string: "https://raw.githubusercontent.com/s-efanov/TCADemo/refs/heads/main/backend_search"
        )!).0
    }
}
