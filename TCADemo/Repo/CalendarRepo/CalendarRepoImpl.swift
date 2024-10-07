import Dependencies
import Foundation

struct CalendarRepoImpl: CalendarRepo {
    func get() async throws -> [CalendarItem] {
        let data = try await URLSession(configuration: .ephemeral).data(from:
               URL(string: "https://raw.githubusercontent.com/s-efanov/TCADemo/refs/heads/main/backend_calendar")!
//            URL(string: "https://api.open-meteo.com/v1/forecast?latitude=53&longitude=35&current=temperature_2m")!
        ).0
        
        var str = String(data: data, encoding: .utf8)!
        str = str.replacingOccurrences(of: "\n", with: "", options: .literal)
        
        do {
            let response = try JSONDecoder().decode(CalendarResponse.self, from: str.data(using: .utf8)!)
            return response.events
        } catch {
            throw NetworkError()
        }
    }
}
