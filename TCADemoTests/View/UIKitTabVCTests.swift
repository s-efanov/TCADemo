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
struct UIKitTabVCTests {
    @Test @MainActor
    func uiKitTabVCInitial() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(
                calendarItems: [CalendarItem(title: "Title", from: "from", to: "to")],
                screenState: .initial
            ),
            reducer: { BindingReducer() }
        )
        
        let view = UIKitTabVC(store: store)
        assertSnapshot(of: view, as: .image)
    }
    
    @Test @MainActor
    func uiKitTabVCLoading() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(screenState: .loading),
            reducer: { BindingReducer() }
        )
        
        let view = UIKitTabVC(store: store)
        assertSnapshot(of: view, as: .image)
    }
    
    @Test @MainActor
    func uiKitTabVCError() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(screenState: .searchError),
            reducer: { BindingReducer() }
        )
        
        let view = UIKitTabVC(store: store)
        assertSnapshot(of: view, as: .image)
    }
    
    @Test @MainActor
    func uiKitTabVCSearchResult() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(screenState: .searchResult([SearchItem(title: "Title", type: "Type")])),
            reducer: { BindingReducer() }
        )
        
        let view = UIKitTabVC(store: store)
        assertSnapshot(of: view, as: .image)
    }
    
    @Test @MainActor
    func uiKitTabViewWithProfile() {
        let store = StoreOf<TabReducer>(
            initialState: TabReducer.State(
                path: StackState<TabPath.State>([
                    .profile(ProfileReducer.State(searchItem: SearchItem(title: "Рома", type: "person")))
                ])
            ),
            reducer: { TabReducer() }
        )
        
        let view = UIKitTabView(store: store)
        assertSnapshot(of: view, as: .image)
    }
}
