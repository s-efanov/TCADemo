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
struct LoginMainReducerTests {
    @Test @MainActor
    func onEnterButtonTappedValidLogin() async {
        let store = TestStore(initialState: LoginReducer.State(login: "123", password: "123")) {
            LoginReducer.MainReducer()
        }
        
        await store.send(.onEnterButtonTapped)
        await store.receive(.delegate(.onLoginComplete))
    }
    
    @Test @MainActor
    func onEnterButtonTappedInvalidLogin() async {
        let store = TestStore(initialState: LoginReducer.State(login: "a", password: "a")) {
            LoginReducer.MainReducer()
        }
        
        await store.send(.onEnterButtonTapped) { state in
            state.destination = .wrongPassword(AlertState {
                TextState("Неверный пароль")
            } actions: {
                ButtonState(role: .cancel, action: .ok) { TextState("ОК") }
            })
        }
    }
    
    @Test @MainActor
    func onAboutAppButtonTapped() async {
        let store = TestStore(initialState: LoginReducer.State()) {
            LoginReducer.MainReducer()
        }
        
        await store.send(.onAboutAppButtonTapped) { state in
            state.destination = .aboutApp(AboutReducer.State())
        }
    }
    
    @Test @MainActor
    func destination() async {
        let store = TestStore(initialState: LoginReducer.State()) {
            LoginReducer.MainReducer()
        }
        
        await store.send(.destination(.dismiss))
    }
    
    @Test @MainActor
    func binding() async {
        let store = TestStore(initialState: LoginReducer.State()) {
            LoginReducer.MainReducer()
        }

        await store.send(.binding(.set(\.login, "")))
    }
}
