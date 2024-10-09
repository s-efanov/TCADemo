//
//  TabMainReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 07.10.2024.
//

import ComposableArchitecture

extension TabReducer {
    @Reducer
    struct MainReducer {
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .onAppear:
                return .send(.calendarRequest(.start))
            case let .calendarRequest(.onSuccess(items)):
                state.calendarItems = items
                return .none
            case let .searchRequest(.onSuccess(items)):
                state.screenState = .searchResult(items)
                return .none
            case .path, .calendarRequest, .searchRequest, .binding, .ui:
                return .none
            }
        }
    }
}
