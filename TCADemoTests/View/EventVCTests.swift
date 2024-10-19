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
struct EventVCTests {
    @Test @MainActor
    func eventVC() {
        let store = StoreOf<EventReducer>(
            initialState: EventReducer.State(calendarItem: CalendarItem(title: "Title", from: "from", to: "to")),
            reducer: { EventReducer() }
        )
        
        let view = EventVC(store: store)
        assertSnapshot(of: view, as: .image)
    }
}
