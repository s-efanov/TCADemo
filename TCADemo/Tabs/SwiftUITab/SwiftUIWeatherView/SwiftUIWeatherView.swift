//
//  Feature2View.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct SwiftUIWeatherView: View {
    let store: StoreOf<SwiftUIWeatherReducer>
    
    var body: some View {
        WithPerceptionTracking { // Обязательно для iOS 16 и ниже
            VStack {
                if store.isLoading {
                    ProgressView()
                }
                if let temperature = store.temperature {
                    Text("\(String(format: "%.1f", temperature)) ℃")
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}
