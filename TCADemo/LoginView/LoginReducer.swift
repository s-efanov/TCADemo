//
//  LoginReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct LoginReducer {
    @ObservableState
    struct State: Equatable {
        var login: String = ""
        var password: String = ""

        @Presents var destination: LoginSheet.State?
    }

    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case destination(PresentationAction<LoginSheet.Action>)

        case onEnterButtonTapped
        case onAboutAppButtonTapped
        
        case delegate(DelegateAction)
    }
    
    enum AlertAction {
        case ok
    }
    
    enum DelegateAction: Equatable {
        case onLoginComplete
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        MainReducer()
            .ifLet(\.$destination, action: \.destination)
    }
}

@Reducer(state: .equatable, action: .equatable)
enum LoginSheet {
    case wrongPassword(AlertState<LoginReducer.AlertAction>)
    case aboutApp(AboutReducer)
}
