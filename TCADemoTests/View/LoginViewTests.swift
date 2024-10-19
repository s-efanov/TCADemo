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
    
    @Test @MainActor
    func loginAbout() async {
        let store = StoreOf<LoginReducer>(
            initialState: LoginReducer.State(destination: .aboutApp(AboutReducer.State())),
            reducer: { LoginReducer.MainReducer() }
        )
        
        let view = LoginView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
    
    @Test @MainActor
    func loginWrongPassword() async {
        let store = StoreOf<LoginReducer>(
            initialState: LoginReducer.State(
                destination: .wrongPassword(AlertState {
                    TextState("Неверный пароль")
                } actions: {
                    ButtonState(role: .cancel, action: .ok) { TextState("ОК") }
                })
            ),
            reducer: { LoginReducer.MainReducer() }
        )
        
        let view = LoginView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
