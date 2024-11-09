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
struct TabMainReducerTests {
    @Test @MainActor
    func onAppear() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.MainReducer()
        }

        await store.send(.onAppear)
        await store.receive(.calendarRequest(.start))
    }
    
    @Test @MainActor
    func calendarRequestOnSuccess() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.MainReducer()
        }
        
        let calendarItem = CalendarItem(title: "title", from: "from", to: "to")

        await store.send(.calendarRequest(.onSuccess([calendarItem]))) { state in
            state.calendarItems = [calendarItem]
        }
    }
    
    @Test @MainActor
    func searchRequestOnSuccess() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.MainReducer()
        }
        
        let search = SearchItem(title: "title", type: "type")

        await store.send(.searchRequest(.onSuccess([search]))) { state in
            state.screenState = .searchResult([search])
        }
    }
    
    @Test @MainActor
    func path() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.MainReducer()
        }

        await store.send(.calendarRequest(.start))
    }
}




//case .path, .calendarRequest, .searchRequest, .binding, .ui:
//    return .none
//}
