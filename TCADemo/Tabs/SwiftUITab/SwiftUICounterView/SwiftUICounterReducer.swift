//
//  Feature1Reducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct SwiftUICounterReducer {
    
    @ObservableState
    struct State: Equatable {
        var counter: Int = 0
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
    }
}
