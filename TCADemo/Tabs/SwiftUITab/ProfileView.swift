import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    let store: StoreOf<ProfileReducer>
    
    var body: some View {
        WithPerceptionTracking { // Обязательно для iOS 16 и ниже
            WithPerceptionTracking { // Обязательно для iOS 16 и ниже
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(store.searchItem.title)
                        Text(store.searchItem.type)
                    }
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
        }
    }
}
