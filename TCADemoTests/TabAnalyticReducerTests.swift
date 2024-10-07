//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by Sergei Efanov on 19.09.2024.
//

import Testing
@testable import TCADemo
import ComposableArchitecture

struct TabAnalyticReducerTests {
    @Test func onTapStartSearch() async {
        let mock = AnalyticServiceMock()
        let store = await makeStore(analyticService: mock)
        await store.send(.ui(.onTapStartSearch))
    }

}

//case .ui(.onTapStartSearch):
//    return .run { send in
//        await analyticService.send("onTapStartSearch")
//    }
//case .ui(.onTapClear):
//    return .run { send in
//        await analyticService.send("onTapClear")
//    }
//case .ui(.onTapSearchItem):
//    return .run { send in
//        await analyticService.send("onTapSearchItem")
//    }
//case .ui(.onTapCalendarEvent):
//    return .run { send in
//        await analyticService.send("onTapCalendarEvent")
//    }

@MainActor
extension TabAnalyticReducerTests {
    typealias Store = TestStore<TabReducer.AnalyticReducer.State, TabReducer.AnalyticReducer.Action>

    func makeStore(
        analyticService: AnalyticServiceMock,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Store {
        
        let reducer = withDependencies {
            $0.analyticService = analyticService
        } operation: {
            TabReducer.AnalyticReducer()
        }
        
        return Store(
            initialState: TabReducer.AnalyticReducer.State(),
            reducer: { reducer },
            file: file,
            line: line
        )
    }
}
