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
        
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.AnalyticReducer()
        } withDependencies: {
            $0.analyticService = analyticMock
        }

        await store.send(.ui(.onTapStartSearch))
        #expect(analyticMock.events == ["onTapStartSearch"])
    }
    
    @Test @MainActor
    func onTapClear() async {
        let analyticMock = AnalyticServiceMock()
        
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.AnalyticReducer()
        } withDependencies: {
            $0.analyticService = analyticMock
        }

        await store.send(.ui(.onTapClear))
        #expect(analyticMock.events == ["onTapClear"])
    }
    
    @Test @MainActor
    func onTapSearchItem() async {
        let analyticMock = AnalyticServiceMock()
        
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.AnalyticReducer()
        } withDependencies: {
            $0.analyticService = analyticMock
        }

        await store.send(.ui(.onTapSearchItem(SearchItem(title: "Title", type: "type"))))
        #expect(analyticMock.events == ["onTapSearchItem"])
    }
    
    @Test @MainActor
    func onTapCalendarEvent() async {
        let analyticMock = AnalyticServiceMock()
        
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.AnalyticReducer()
        } withDependencies: {
            $0.analyticService = analyticMock
        }

        await store.send(.ui(.onTapCalendarEvent(CalendarItem(title: "Title", from: "from", to: "to"))))
        #expect(analyticMock.events == ["onTapCalendarEvent"])
    }
}
