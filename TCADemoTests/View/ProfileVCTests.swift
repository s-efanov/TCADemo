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
struct ProfileVCTests {
    @Test @MainActor
    func profileVC() {
        let store = StoreOf<ProfileReducer>(
            initialState: ProfileReducer.State(searchItem: SearchItem(title: "Title", type: "type")),
            reducer: { ProfileReducer() }
        )
        
        let view = ProfileVC(store: store)
        assertSnapshot(of: view, as: .image)
    }
}
