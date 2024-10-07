import Foundation
import Dependencies

private enum AnalyticServiceKey: DependencyKey {
    static let liveValue: any AnalyticService = AnalyticServiceImpl()
    static let testValue: any AnalyticService = AnalyticServiceMock()
}

extension DependencyValues {
    var analyticService: any AnalyticService {
        get { self[AnalyticServiceKey.self] }
        set { self[AnalyticServiceKey.self] = newValue }
    }
}
