//
//  Feature3Reducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct UIKitCounterReducer {
    
    @ObservableState
    struct State: Equatable {
        var counter: Int = 0
    }

    enum Action: Equatable {
        case onTapPlusButton
        case onTapMinusButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onTapPlusButton:
                state.counter += 1
                return .none
            case .onTapMinusButton:
                state.counter -= 1
                return .none
            }
        }
    }
}
