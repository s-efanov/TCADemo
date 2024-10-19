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
struct ProfileViewTests {
    @Test @MainActor
    func profileView() {
        let store = StoreOf<ProfileReducer>(
            initialState: ProfileReducer.State(searchItem: SearchItem(title: "Title", type: "type")),
            reducer: { ProfileReducer() }
        )
        
        let view = ProfileView(store: store)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
