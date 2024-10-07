//
//  Feature2Reducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

extension TabReducer {
    @Reducer
    struct SearchRequestReducer {
        @Dependency(\.searchRepo) var searchRepo

        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            guard case let .searchRequest(searchAction) = action else { return .none }
            switch searchAction {
            case .start:
//                state.isLoading = true
                return .run { send in
                    do {
                        try await send(.searchRequest(.onSuccess(searchRepo.get())))
                    } catch {
                        await send(.searchRequest(.onError))
                    }
                }
            case let .onSuccess(value):
//                state.isLoading = false
                //            state.temperature = value
                return .none
            case .onError:
//                state.isLoading = false
                return .none
            }
        }
    }
    
    enum SearchReducerAction: Equatable {
        case start
        case onSuccess([SearchItem])
        case onError
    }
}
