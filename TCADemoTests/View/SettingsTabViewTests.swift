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
struct SettingsTabViewTests {
    @Test @MainActor
    func settingsView() {
        let store = StoreOf<SettingsTabReducer>(
            initialState: SettingsTabReducer.State(),
            reducer: { SettingsTabReducer() }
        )
        
        let view = SettingsTabView(store: store)
        assertSnapshot(of: view, as: .image)
    }
}
