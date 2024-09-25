//
//  LoginMainReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

extension LoginReducer {
    @Reducer
    struct MainReducer {
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .onEnterButtonTapped:
                if state.login == "123" && state.password == "123" {
                    return .send(.delegate(.onLoginComplete))
                } else {
                    state.destination = .wrongPassword(AlertState {
                        TextState("Неверный пароль")
                    } actions: {
                        ButtonState(role: .cancel, action: .ok) { TextState("ОК") }
                    })
                    return .none
                }
            case .binding:
                return .none
            case .destination:
                return .none
            case .onAboutAppButtonTapped:
                state.destination = .aboutApp(AboutReducer.State())
                return .none
            case .delegate:
                return .none
            }
        }
    }
}
