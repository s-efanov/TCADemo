//
//  ProfileReducer.swift
//  TCADemo
//
//  Created by Sergei Efanov on 07.10.2024.
//

import ComposableArchitecture

@Reducer
struct ProfileReducer {
    @ObservableState
    struct State: Equatable {
        let searchItem: SearchItem
    }
}
