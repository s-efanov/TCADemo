//
//  AboutView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct AboutView: View {
    let store: StoreOf<AboutReducer>
    
    var body: some View {
        Text("AboutView")
    }
}
