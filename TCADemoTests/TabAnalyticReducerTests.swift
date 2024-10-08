//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by Sergei Efanov on 19.09.2024.
//

import Testing
@testable import TCADemo
import ComposableArchitecture

@Suite
struct TabAnalyticReducerTests {
    @Test
    func onTapStartSearch() async {
        var mock = AnalyticServiceMock()
        
        let store = await TestStore(initialState: TabReducer.State()) {
            TabReducer.AnalyticReducer()
        } withDependencies: {
            $0.context = .test
            $0.analyticService = mock
        }

        await store.send(.ui(.onTapStartSearch))
        let events = (store.dependencies.analyticService as? AnalyticServiceMock)?.events
        print(store.dependencies.analyticService)
        print((store.dependencies.analyticService as! AnalyticServiceMock))
        print((store.dependencies.analyticService as? AnalyticServiceMock)!.events)
        print(mock.events)
        #expect(events == [])
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
