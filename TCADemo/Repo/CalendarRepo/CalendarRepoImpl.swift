import Dependencies
import Foundation

struct CalendarRepoImpl: CalendarRepo {
    func get() async throws -> [CalendarItem] {
        try decode(data: try await request())
    }
    
    func decode(data: Data) throws -> [CalendarItem] {
        var str = String(data: data, encoding: .utf8)!
        str = str.replacingOccurrences(of: "\n", with: "", options: .literal)
        
        do {
            let response = try JSONDecoder().decode(CalendarResponse.self, from: str.data(using: .utf8)!)
            return response.events
        } catch {
            throw NetworkError(error: error)
        }
    }
    
    func request() async throws -> Data {
        try await URLSession(configuration: .ephemeral).data(from: URL(
            string: "https://raw.githubusercontent.com/s-efanov/TCADemo/refs/heads/main/backend_calendar"
        )!).0
    }
}
