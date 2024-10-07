import Foundation

public class AnalyticServiceMock: AnalyticService {
    var events = [String]()
    
    func send(_ name: String) async {
        events.append(name)
    }
}
