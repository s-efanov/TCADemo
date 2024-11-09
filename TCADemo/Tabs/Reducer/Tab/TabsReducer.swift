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
        
        var swiftUITab = SearchReducer.State()
        var uiKitTab = SearchReducer.State()
        var settingsTab = SettingsTabReducer.State()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        
        case swiftUITab(SearchReducer.Action)
        case uiKitTab(SearchReducer.Action)
        case settingsTab(SettingsTabReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.swiftUITab, action: \.swiftUITab) {
            SearchReducer()
        }
        Scope(state: \.uiKitTab, action: \.uiKitTab) {
            SearchReducer()
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
