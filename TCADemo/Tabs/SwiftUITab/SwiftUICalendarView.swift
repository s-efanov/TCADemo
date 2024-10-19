import ComposableArchitecture
import SwiftUI

struct CalendarView: View {
    @Perception.Bindable var store: StoreOf<TabReducer>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("SwiftUI")
                if store.searchEnabled {
                    HStack {
                        TextField("Поиск", text: $store.searchText)
                            .padding(8)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 4).strokeBorder(Color.gray.opacity(0.5), lineWidth: 1))
                        if store.screenState.items.isEmpty {
                            Button("Найти", action: { store.send(.ui(.onTapStartSearch)) })
                        } else {
                            Button("Очистить", action: { store.send(.ui(.onTapClear)) })
                        }
                    }
                    .padding(.horizontal, 8)
                }
                
                switch store.screenState {
                case .initial:
                    ScrollView(.vertical) {
                        VStack(spacing: 16) {
                            ForEach(store.calendarItems, id: \.title) { item in
                                Button {
                                    store.send(.ui(.onTapCalendarEvent(item)))
                                } label: {
                                    CalendarItemView(calendarItem: item)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                case let .searchResult(items):
                    ScrollView(.vertical) {
                        VStack(spacing: 16) {
                            ForEach(items, id: \.title) { item in
                                Button {
                                    store.send(.ui(.onTapSearchItem(item)))
                                } label: {
                                    SearchItemView(item: item)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                case .searchError:
                    Text("Ошибка")
                case .loading:
                    ProgressView()
                }
            }
            .padding(.top, 40)
            .task {
                store.send(.onAppear)
            }
        }
    }
}

struct CalendarItemView: View {
    let calendarItem: CalendarItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(calendarItem.title)
                Text(calendarItem.from + " - " + calendarItem.to)
            }
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

struct SearchItemView: View {
    let item: SearchItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                Text(item.type)
            }
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
