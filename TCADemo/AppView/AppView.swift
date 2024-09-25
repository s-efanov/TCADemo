//
//  ContentView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppReducer>
    
    var body: some View {
        WithPerceptionTracking {
            let store = store.scope(state: \.destination, action: \.destination)
            switch store.case {
            case let .login(store):
                LoginView(store: store)
            case let .tabs(store):
                TabsView(store: store)
            }
        }
        .onAppear {
            store.send(.appOnAppear)
        }
    }
}

#Preview {
    AppView(store: StoreOf<AppReducer>(
        initialState: AppReducer.State(),
        reducer: { AppReducer() })
    )
}
