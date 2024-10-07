//
//  SettingsView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct SettingsTabView: View {
    @Perception.Bindable var store: StoreOf<SettingsTabReducer>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Toggle("Search", isOn: $store.searchEnabled)
                Button(action: { store.send(.onLogoutButtonTapped) }, label: { Text("Выход") })
            }
            .padding()
        }
    }
}
