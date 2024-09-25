//
//  TabsView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct TabsView: View {
    @Perception.Bindable var store: StoreOf<TabsReducer>
    
    var body: some View {
        WithPerceptionTracking {
            TabView(selection: $store.currentTab) {
                SwiftUITabView(store: store.scope(state: \.swiftUITab, action: \.swiftUITab))
                    .tag(Tab.swiftUI)
                    .tabItem { Label("SwiftUI", systemImage: "swift") }
                UIKitTabView(store: store.scope(state: \.uiKitTab, action: \.uiKitTab))
                    .tag(Tab.uiKit)
                    .tabItem { Label("UIKit", systemImage: "person.crop.rectangle") }
                SettingsTabView(store: store.scope(state: \.settingsTab, action: \.settingsTab))
                    .tag(Tab.settings)
                    .tabItem { Label("Settings", systemImage: "gear.circle") }
            }
        }
    }
}
