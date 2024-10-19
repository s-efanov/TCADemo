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
struct AppViewTests {
    @Test @MainActor
    func appView() {
        let store = StoreOf<AppReducer>(
            initialState: AppReducer.State(),
            reducer: { AppReducer() }
        )
        
        let view = AppView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
    
    @Test @MainActor
    func appViewTabs() {
        let store = StoreOf<AppReducer>(
            initialState: AppReducer.State(isLoggedIn: Shared(true), destination: .tabs(TabsReducer.State())),
            reducer: { AppReducer() }
        )
        
        let view = AppView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
