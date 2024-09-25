//
//  Feature1View.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct SwiftUICounterView: View {
    @Perception.Bindable var store: StoreOf<SwiftUICounterReducer>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 16) {
                Text("Counter: \(store.counter)")
                Stepper(value: $store.counter, label: { Text("Counter") })
                    .labelsHidden()
            }
            .padding()
        }
    }
}
