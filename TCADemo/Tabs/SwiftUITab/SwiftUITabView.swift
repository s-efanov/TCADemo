//
//  MainScreenView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct SwiftUITabView: View {
    @Perception.Bindable var store: StoreOf<SwiftUITabReducer>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack(spacing: 16) {
                    if store.swiftUICounterEnabled {
                        Button(action: { store.send(.onTapSwiftUICounterButton) }, label: { Text("SwiftUI Counter") })
                    }
                    
                    if store.swiftUIWeatherEnabled {
                        Button(action: { store.send(.onTapSwiftUIWeatherButton) }, label: { Text("SwiftUI Weather") })
                    }
                }
            } destination: { store in
                WithPerceptionTracking {
                    switch store.case {
                    case let .swiftUICounter(store):
                        SwiftUICounterView(store: store)
                    case let .swiftUIWeather(store):
                        SwiftUIWeatherView(store: store)
                    }
                }
            }
        }
    }
}
