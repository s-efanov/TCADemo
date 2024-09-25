import Dependencies
import Foundation

struct WeatherRepoImpl: WeatherRepo {
    func get() async throws -> Double {
        let data = try await URLSession.shared.data(from:
            URL(string: "https://api.open-meteo.com/v1/forecast?latitude=53&longitude=35&current=temperature_2m")!
        ).0
        
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String : Any] else {
            throw MyError()
        }
        let temperature: Double? = (dict["current"] as? [String: Any])?["temperature_2m"] as? Double
        
        if let temperature {
            return temperature
        }
        
        throw MyError()
    }
}

struct MyError: Error {
    
}
