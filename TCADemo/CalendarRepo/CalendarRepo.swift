import Foundation

protocol WeatherRepo {
    func get() async throws -> Double
}
