//
//  UIReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 07.10.2024.
//

import ComposableArchitecture

extension TabReducer {
    @Reducer
    struct UIReducer {
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            guard case let .ui(uiAction) = action else { return .none }
            switch uiAction {
            case let .onTapCalendarEvent(item):
                state.path.append(.event(EventReducer.State(calendarItem: item)))
                return .none
            case let .onTapSearchItem(item):
                state.path.append(.profile(ProfileReducer.State(searchItem: item)))
                return .none
            case .onTapStartSearch:
                return .send(.searchRequest(.start))
            case .onTapClear:
                state.searchText = ""
                state.screenState = .initial
                return .none
            }
        }
    }
    
    enum UIReducerAction: Equatable {
        case onTapCalendarEvent(CalendarItem)
        case onTapSearchItem(SearchItem)
        case onTapStartSearch
        case onTapClear
    }
}
