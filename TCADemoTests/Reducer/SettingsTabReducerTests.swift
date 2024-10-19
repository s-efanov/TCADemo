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
struct SettingsTabReducerTests {
    @Test @MainActor
    func onLogoutButtonTapped() async {
        let store = TestStore(initialState: SettingsTabReducer.State()) {
            SettingsTabReducer()
        }

        await store.send(.onLogoutButtonTapped)
        await store.receive(.delegate(.onLogout))
    }
    
    @Test @MainActor
    func binding() async {
        let store = TestStore(initialState: SettingsTabReducer.State()) {
            SettingsTabReducer()
        }

        await store.send(.binding(.set(\.searchEnabled, true)))
    }
}
