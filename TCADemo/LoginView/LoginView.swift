//
//  LoginView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//
import SwiftUI
import ComposableArchitecture
import Perception

struct LoginView: View {
    @Perception.Bindable var store: StoreOf<LoginReducer>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Spacer()
                TextField("Login", text: $store.login)
                SecureField("Password", text: $store.password)
                Button(action: { store.send(.onEnterButtonTapped) }, label: { Text("Вход") })
                Spacer()
                Button(action: { store.send(.onAboutAppButtonTapped) }, label: { Text("О приложении") })
            }
            .padding()
            .autocorrectionDisabled()
            .textFieldStyle(.roundedBorder)
            .alert(
                $store.scope(state: \.destination?.wrongPassword, action: \.destination.wrongPassword)
            )
            .sheet(
                item: $store.scope(state: \.destination?.aboutApp, action: \.destination.aboutApp)
            ) { store in
                AboutView(store: store)
            }
        }
    }
}
