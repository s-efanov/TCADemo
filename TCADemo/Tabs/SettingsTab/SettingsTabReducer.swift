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
        @Shared(.swiftUICounterEnabled) var swiftUICounterEnabled
        @Shared(.swiftUIWeatherEnabled) var swiftUIWeatherEnabled
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
    static var swiftUIWeatherEnabled: Self {
        PersistenceKeyDefault(.inMemory("swiftUIWeatherEnabled"), true)
    }
}

extension PersistenceReaderKey where Self == PersistenceKeyDefault<InMemoryKey<Bool>> {
    static var swiftUICounterEnabled: Self {
        PersistenceKeyDefault(.inMemory("swiftUICounterEnabled"), true)
    }
}

extension PersistenceReaderKey where Self == PersistenceKeyDefault<AppStorageKey<Bool>> {
    static var isLoggedIn: Self {
        PersistenceKeyDefault(.appStorage("isLoggedIn"), false)
    }
}
