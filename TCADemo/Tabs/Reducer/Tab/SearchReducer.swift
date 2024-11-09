//
//  MainScreenReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct SearchReducer {
    @ObservableState
    struct State: Equatable {
        @SharedReader(.searchEnabled) var searchEnabled
        var path = StackState<TabPath.State>()
        var calendarItems = [CalendarItem]()
        
        var searchText: String = ""
        var screenState: ScreenState = .initial
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear
        case path(StackActionOf<TabPath>)
        
        case searchRequest(SearchReducerAction)
        case calendarRequest(CalendarRequestAction)
        case ui(UIReducerAction)
    }
    
    enum ScreenState: Equatable {
        case initial
        case loading
        case searchResult([SearchItem])
        case searchError
        
        var items: [SearchItem] {
            if case let .searchResult(items) = self {
                return items
            }
            return []
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        MainReducer()
            .forEach(\.path, action: \.path)
        UIReducer()
        SearchRequestReducer()
        CalendarRequestReducer()
        AnalyticReducer()
    }
}

@Reducer(state: .equatable, action: .equatable)
enum TabPath {
    case profile(ProfileReducer)
    case event(EventReducer)
}
