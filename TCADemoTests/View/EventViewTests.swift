//
//  AppViewTests.swift
//  TCADemo
//
//  Created by Sergei Efanov on 09.10.2024.
//

import Testing
import SnapshotTesting
import ComposableArchitecture
@testable import TCADemo

@Suite
struct EventViewTests {
    @Test @MainActor
    func eventView() {
        let store = StoreOf<EventReducer>(
            initialState: EventReducer.State(calendarItem: CalendarItem(title: "Title", from: "from", to: "to")),
            reducer: { EventReducer() }
        )
        
        let view = EventView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
