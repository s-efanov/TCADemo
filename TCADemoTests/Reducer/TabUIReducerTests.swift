import Testing
@testable import TCADemo
import ComposableArchitecture

@Suite
struct TabUIReducerTests {
    @Test @MainActor
    func onTapCalendarEvent() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.UIReducer()
        }
        
        let calendarItem = CalendarItem(title: "title", from: "from", to: "to")

        await store.send(.ui(.onTapCalendarEvent(calendarItem))) { state in
            state.path.append(.event(EventReducer.State(calendarItem: calendarItem)))
        }
    }
    
    @Test @MainActor
    func onTapSearchItem() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.UIReducer()
        }
        
        let searchItem = SearchItem(title: "title", type: "type")

        await store.send(.ui(.onTapSearchItem(searchItem))) { state in
            state.path.append(.profile(ProfileReducer.State(searchItem: searchItem)))
        }
    }
    
    @Test @MainActor
    func onTapStartSearch() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer.UIReducer()
        }

        await store.send(.ui(.onTapStartSearch))
        await store.receive(.searchRequest(.start))
    }
    
    @Test @MainActor
    func onTapClear() async {
        let store = TestStore(initialState: SearchReducer.State(searchText: "abc", screenState: .loading)) {
            SearchReducer.UIReducer()
        }

        await store.send(.ui(.onTapClear)) { state in
            state.searchText = ""
            state.screenState = .initial
        }
    }
}
