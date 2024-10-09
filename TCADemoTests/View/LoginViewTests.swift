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
struct LoginViewTests {
    @Test @MainActor
    func loginView() async {
        let store = StoreOf<LoginReducer>(
            initialState: LoginReducer.State(),
            reducer: { LoginReducer.MainReducer() }
        )
        
        let view = LoginView(store: store)
        try? await Task.sleep(nanoseconds: 100)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
