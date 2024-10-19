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
    struct State: Equatable {
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
        MainReducer()
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
