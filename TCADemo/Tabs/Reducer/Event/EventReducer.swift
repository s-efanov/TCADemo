//
//  EventReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 07.10.2024.
//

import ComposableArchitecture

@Reducer
struct EventReducer {
    @ObservableState
    struct State: Equatable {
        let calendarItem: CalendarItem
    }
}
