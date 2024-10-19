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
struct AboutViewTests {
    @Test @MainActor
    func aboutView() {
        let store = StoreOf<AboutReducer>(
            initialState: AboutReducer.State(),
            reducer: { AboutReducer() }
        )
        
        let view = AboutView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
