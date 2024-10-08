//
//  AnalyticReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 07.10.2024.
//

import ComposableArchitecture

extension TabReducer {
    @Reducer
    struct AnalyticReducer: Reducer {
        @Dependency(\.analyticService) var analyticService
        
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .ui(.onTapStartSearch):
                analyticService.send("onTapStartSearch")
                return .none
            case .ui(.onTapClear):
                analyticService.send("onTapClear")
                return .none
            case .ui(.onTapSearchItem):
                analyticService.send("onTapSearchItem")
                return .none
            case .ui(.onTapCalendarEvent):
                analyticService.send("onTapCalendarEvent")
                return .none
            default:
                return .none
            }
        }
    }
}
