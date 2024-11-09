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
struct SwiftUITabViewTests {
    @Test @MainActor
    func swiftUITabViewWithProfile() {
        let store = StoreOf<SearchReducer>(
            initialState: SearchReducer.State(
                path: StackState<TabPath.State>([
                    .profile(ProfileReducer.State(searchItem: SearchItem(title: "Рома", type: "person")))
                ])
            ),
            reducer: { SearchReducer() }
        )
        
        let view = SwiftUITabView(store: store)
        assertSnapshot(of: view, as: .image)
    }
    
    @Test @MainActor
    func swiftUITabViewWithSearch() {
        let store = StoreOf<SearchReducer>(
            initialState: SearchReducer.State(
                path: StackState<TabPath.State>([
                    .event(EventReducer.State(calendarItem: CalendarItem(title: "Event", from: "10:00", to: "11:00")))
                ])
            ),
            reducer: { SearchReducer() }
        )
        
        let view = SwiftUITabView(store: store)
        assertSnapshot(of: view, as: .image)
    }
}
