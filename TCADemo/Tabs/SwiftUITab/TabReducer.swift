//
//  MainScreenReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct SwiftUITabReducer {
    @ObservableState
    struct State: Equatable {
        @SharedReader(.swiftUICounterEnabled) var swiftUICounterEnabled
        @SharedReader(.swiftUIWeatherEnabled) var swiftUIWeatherEnabled
        var path = StackState<SwiftUITabPath.State>()
        var calendarItems = [CalendarItem]()
        var searchItems = [SearchItem]()
    }
    
    enum Action: Equatable {
        case path(StackActionOf<SwiftUITabPath>)
        
        case onTapSwiftUICounterButton
        case onTapSwiftUIWeatherButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onTapSwiftUICounterButton:
                state.path.append(.swiftUICounter(SwiftUICounterReducer.State()))
                return .none
            case .onTapSwiftUIWeatherButton:
                state.path.append(.swiftUIWeather(SwiftUIWeatherReducer.State()))
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

@Reducer(state: .equatable, action: .equatable)
enum SwiftUITabPath {
    case swiftUICounter(SwiftUICounterReducer)
    case swiftUIWeather(SwiftUIWeatherReducer)
}
