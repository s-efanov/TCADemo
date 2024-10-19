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
                return .run { send in
                    analyticService.send("onTapStartSearch")
                }
            case .ui(.onTapClear):
                return .run { send in
                    analyticService.send("onTapClear")
                }
            case .ui(.onTapSearchItem):
                return .run { send in
                    analyticService.send("onTapSearchItem")
                }
            case .ui(.onTapCalendarEvent):
                return .run { send in
                    analyticService.send("onTapCalendarEvent")
                }
            default:
                return .none
            }
        }
    }
}
