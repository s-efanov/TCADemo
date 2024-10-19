//
//  AppViewTests.swift
//  TCADemo
//
//  Created by Sergei Efanov on 09.10.2024.
//

import Testing
import SnapshotTesting
import ComposableArchitecture
@testable import TCADemo

@Suite
struct SwiftUICalendarViewTests {
    @Test @MainActor
    func swiftUITabVCInitial() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(
                calendarItems: [CalendarItem(title: "Title", from: "from", to: "to")],
                screenState: .initial
            ),
            reducer: { BindingReducer() }
        )
        
        let view = CalendarView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
    
    @Test @MainActor
    func swiftUITabVCLoading() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(screenState: .loading),
            reducer: { BindingReducer() }
        )
        
        let view = CalendarView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
    
    @Test @MainActor
    func swiftUITabVCError() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(screenState: .searchError),
            reducer: { BindingReducer() }
        )
        
        let view = CalendarView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
    
    @Test @MainActor
    func swiftUITabVCSearchResult() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(screenState: .searchResult([SearchItem(title: "Title", type: "Type")])),
            reducer: { BindingReducer() }
        )
        
        let view = CalendarView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
