//
//  CalendarRequestReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 07.10.2024.
//

import ComposableArchitecture

extension SearchReducer {
    @Reducer
    struct CalendarRequestReducer {
        @Dependency(\.calendarRepo) var calendarRepo
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            guard case let .calendarRequest(calendarAction) = action else { return .none }
            switch calendarAction {
            case .start:
                return .run { send in
                    do {
                        try await send(.calendarRequest(.onSuccess(calendarRepo.get())))
                    } catch {
                        await send(.calendarRequest(.onError(NetworkError(error: error))))
                    }
                }
            case .onSuccess:
                return .none
            case .onError:
                return .none
            }
        }
    }
    
    enum CalendarRequestAction: Equatable {
        case start
        case onSuccess([CalendarItem])
        case onError(NetworkError)
    }
}
