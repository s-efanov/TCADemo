import Foundation

protocol AnalyticService {
    func send(_ name: String) async
}
