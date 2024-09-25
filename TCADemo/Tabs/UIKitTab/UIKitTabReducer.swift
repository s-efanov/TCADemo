//
//  SecondReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct UIKitTabReducer {
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<UIKitTabPath.State>()
    }
    
    enum Action: Equatable, BindableAction {
        case path(StackActionOf<UIKitTabPath>)
        case binding(BindingAction<State>)
        
        case onTapUIKitCounterButton
        case onTapUIKitWeatherButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onTapUIKitCounterButton:
                state.path.append(.uiKitCounter(UIKitCounterReducer.State()))
                return .none
            case .onTapUIKitWeatherButton:
                state.path.append(.uiKitWeather(UIKitWeatherReducer.State()))
                return .none
            case .binding:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        BindingReducer()
    }
}


@Reducer(state: .equatable, action: .equatable)
enum UIKitTabPath {
    case uiKitCounter(UIKitCounterReducer)
    case uiKitWeather(UIKitWeatherReducer)
}
