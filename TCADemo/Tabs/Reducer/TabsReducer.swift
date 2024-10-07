//
//  TabsReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct TabsReducer {
    
    @ObservableState
    struct State: Equatable {
        var currentTab: Tab = .swiftUI
        
        var swiftUITab = TabReducer.State()
        var uiKitTab = TabReducer.State()
        var settingsTab = SettingsTabReducer.State()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        
        case swiftUITab(TabReducer.Action)
        case uiKitTab(TabReducer.Action)
        case settingsTab(SettingsTabReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.swiftUITab, action: \.swiftUITab) {
            TabReducer()
        }
        Scope(state: \.uiKitTab, action: \.uiKitTab) {
            TabReducer()
        }
        Scope(state: \.settingsTab, action: \.settingsTab) {
            SettingsTabReducer()
        }
    }
}

enum Tab: Equatable {
    case swiftUI
    case uiKit
    case settings
}
