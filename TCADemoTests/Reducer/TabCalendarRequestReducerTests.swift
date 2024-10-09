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
struct TabCalendarRequestReducerTests {
    @Test @MainActor
    func success() async {
        let requestCalendarMock = CalendarRepoMock(
            result: .success([CalendarItem(title: "Title", from: "from", to: "to")])
        )
        
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer.CalendarRequestReducer()
        } withDependencies: {
            $0.calendarRepo = requestCalendarMock
        }

        await store.send(.calendarRequest(.start))
        await store.receive(.calendarRequest(.onSuccess(
            [CalendarItem(title: "Title", from: "from", to: "to")]
        )))
    }
    
    @Test @MainActor
    func failure() async {
        let requestCalendarMock = CalendarRepoMock(
            result: .failure(NetworkError())
        )
        
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer.CalendarRequestReducer()
        } withDependencies: {
            $0.calendarRepo = requestCalendarMock
        }

        await store.send(.calendarRequest(.start))
        await store.receive(.calendarRequest(.onError(
            NetworkError()
        )))
    }
}
