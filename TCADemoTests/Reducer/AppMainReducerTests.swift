//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by Sergei Efanov on 19.09.2024.
//

import Testing
@testable import TCADemo
import ComposableArchitecture
import Foundation

@Suite
struct AppMainReducerTests {
    @Test @MainActor
    func destinationLoginDelegateOnLoginComplete() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(false))) {
            AppReducer.MainReducer()
        }
        
        await store.send(.destination(.login(.delegate(.onLoginComplete)))) { state in
            state.isLoggedIn = true
        }
        await store.receive(.checkLogin) { state in
            state.destination = .tabs(TabsReducer.State())
        }
    }
    
    @Test @MainActor
    func destinationTabsSettingsTabOnLogout() async {
        let store = TestStore(initialState: AppReducer.State(
            isLoggedIn: Shared(true),
            destination: .tabs(TabsReducer.State())
        )) {
            AppReducer.MainReducer()
        }
        
        await store.send(.destination(.tabs(.settingsTab(.delegate(.onLogout))))) { state in
            state.isLoggedIn = false
        }
        await store.receive(.checkLogin) { state in
            state.destination = .login(LoginReducer.State())
        }
    }
    
    @Test @MainActor
    func checkLoginIsLoggedIn() async {
        let store = TestStore(initialState: AppReducer.State(
            isLoggedIn: Shared(true)
        )) {
            AppReducer.MainReducer()
        }
        
        await store.send(.checkLogin) { state in
            state.destination = .tabs(TabsReducer.State())
        }
    }
    
    @Test @MainActor
    func checkLoginIsNoLoggedIn() async {
        let store = TestStore(initialState: AppReducer.State(
            isLoggedIn: Shared(false),
            destination: .tabs(TabsReducer.State())
        )) {
            AppReducer.MainReducer()
        }
        
        await store.send(.checkLogin) { state in
            state.destination = .login(LoginReducer.State())
        }
    }
    
    @Test @MainActor
    func onAppear() async {
        let store = TestStore(initialState: AppReducer.State()) {
            AppReducer.MainReducer()
        }
        
        await store.send(.appOnAppear)
        await store.receive(.checkLogin)
    }
    
    @Test @MainActor
    func onURLOppened() async {
        let store = TestStore(initialState: AppReducer.State()) {
            AppReducer.MainReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "https://www.ya.ru")!))
    }
}
