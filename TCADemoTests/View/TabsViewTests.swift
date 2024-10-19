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
struct TabsViewTests {
    @Test @MainActor
    func tabsView() {
        let store = StoreOf<TabsReducer>(
            initialState: TabsReducer.State(),
            reducer: { TabsReducer() }
        )
        
        let view = TabsView(store: store)
        assertSnapshot(of: view, as: .image)
    }
}
