import Dependencies
import Foundation

struct SearchRepoImpl: SearchRepo {
    func get() async throws -> [SearchItem] {
        let data = try await URLSession(configuration: .ephemeral).data(from:
               URL(string: "https://raw.githubusercontent.com/s-efanov/TCADemo/refs/heads/main/backend_search")!
//            URL(string: "https://api.open-meteo.com/v1/forecast?latitude=53&longitude=35&current=temperature_2m")!
        ).0
        
        var str = String(data: data, encoding: .utf8)!
        str = str.replacingOccurrences(of: "\n", with: "", options: .literal)
        
        do {
            let response = try JSONDecoder().decode(SearchResponse.self, from: str.data(using: .utf8)!)
            return response.search
        } catch {
            throw NetworkError()
        }
    }
}
