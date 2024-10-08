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
    @Test @MainActor
    func onTapStartSearch() async {
        let analyticMock = AnalyticServiceMock()
        
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer.AnalyticReducer()
        } withDependencies: {
            $0.analyticService = analyticMock
        }

        await store.send(.ui(.onTapStartSearch))
        #expect(analyticMock.events == ["onTapStartSearch"])
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
