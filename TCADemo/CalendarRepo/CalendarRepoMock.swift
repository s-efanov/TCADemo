import Foundation

struct WeatherRepoMock: WeatherRepo {
    func get() async throws -> Double {
        0
    }
}
