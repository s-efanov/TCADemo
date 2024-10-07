//
//  AppReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AppReducer {
    
    @ObservableState
    struct State {
        @Shared(.isLoggedIn) var isLoggedIn
        var destination: AppDestination.State = .login(LoginReducer.State())
    }
    
    @CasePathable
    enum Action: Equatable {
        case destination(AppDestination.Action)
        case appOnAppear
        
        case checkLogin
        case onURLOppened(URL)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination(.login(.delegate(.onLoginComplete))):
                state.isLoggedIn = true
                return .send(.checkLogin)
            case .destination(.tabs(.settingsTab(.delegate(.onLogout)))):
                state.isLoggedIn = false
                return .send(.checkLogin)
            case .destination:
                return .none
            case .appOnAppear:
                return .send(.checkLogin)
            case .checkLogin:
                if state.isLoggedIn {
                    state.destination = .tabs(TabsReducer.State())
                } else {
                    state.destination = .login(LoginReducer.State())
                }
                return .none
            case .onURLOppened:
                return .none
            }
        }
        .ifLet(\.destination.login, action: \.destination.login) { LoginReducer() }
        .ifLet(\.destination.tabs, action: \.destination.tabs) { TabsReducer() }
        
        DeeplinkReducer()
    }
}


@Reducer(state: .equatable, action: .equatable)
enum AppDestination {
    case login(LoginReducer)
    case tabs(TabsReducer)
}
