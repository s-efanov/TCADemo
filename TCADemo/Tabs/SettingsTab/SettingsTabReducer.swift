//
//  SettingsReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import ComposableArchitecture

@Reducer
struct SettingsTabReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.searchEnabled) var searchEnabled
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case onLogoutButtonTapped
        
        case delegate(DelegateAction)
    }
    
    enum DelegateAction: Equatable {
        case onLogout
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLogoutButtonTapped:
                return .send(.delegate(.onLogout))
            case .binding:
                return .none
            case .delegate:
                return .none
            }
        }
        BindingReducer()
    }
}

extension PersistenceReaderKey where Self == PersistenceKeyDefault<InMemoryKey<Bool>> {
    static var searchEnabled: Self {
        PersistenceKeyDefault(.inMemory("searchEnabled"), true)
    }
}

extension PersistenceReaderKey where Self == PersistenceKeyDefault<AppStorageKey<Bool>> {
    static var isLoggedIn: Self {
        PersistenceKeyDefault(.appStorage("isLoggedIn"), false)
    }
}
