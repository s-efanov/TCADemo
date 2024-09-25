//
//  TCADemoApp.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCADemoApp: App {
    @State var store = StoreOf<AppReducer>(
        initialState: AppReducer.State(),
        reducer: { AppReducer() }
    )
    
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
                .onOpenURL {
                    store.send(.onURLOppened($0))
                }
        }
    }
}
