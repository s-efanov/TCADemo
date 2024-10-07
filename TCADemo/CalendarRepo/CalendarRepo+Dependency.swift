import Foundation
import Dependencies

private enum WeatherRepoKey: DependencyKey {
    static let liveValue: any WeatherRepo = WeatherRepoImpl()
    static let testValue: any WeatherRepo = WeatherRepoMock()
}

extension DependencyValues {
    var weatherRepo: any WeatherRepo {
        get { self[WeatherRepoKey.self] }
        set { self[WeatherRepoKey.self] = newValue }
    }
}
