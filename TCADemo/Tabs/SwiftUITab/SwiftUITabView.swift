//
//  MainScreenView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct SwiftUITabView: View {
    @Perception.Bindable var store: StoreOf<TabReducer>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                CalendarView(store: store)
            } destination: { store in
                WithPerceptionTracking {
                    switch store.case {
                    case let .profile(store):
                        ProfileView(store: store)
                    case let .event(store):
                        EventView(store: store)
                    }
                }
            }
        }
    }
}
