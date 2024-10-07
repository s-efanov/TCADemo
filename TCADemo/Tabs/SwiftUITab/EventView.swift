//
//  Feature2View.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct EventView: View {
    let store: StoreOf<EventReducer>
    
    var body: some View {
        WithPerceptionTracking { // Обязательно для iOS 16 и ниже
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(store.calendarItem.title)
                    Text(store.calendarItem.from + " - " + store.calendarItem.to)
                }
                Spacer()
            }
            .padding(.horizontal, 8)
        }
    }
}
