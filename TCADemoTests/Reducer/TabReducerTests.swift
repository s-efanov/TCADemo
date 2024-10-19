import Testing
@testable import TCADemo
import ComposableArchitecture

@Suite
struct TabReducerTests {
    @Test @MainActor
    func onTapClear() async {
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer()
        }

        await store.send(.searchRequest(.onError(NetworkError())))
    }
    
    @Test @MainActor
    func searchRequestOnSuccess() async {
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer()
        }
        
        let searchItem = SearchItem(title: "title", type: "type")

        await store.send(.searchRequest(.onSuccess([searchItem]))) { state in
            state.screenState = .searchResult([searchItem])
        }
    }
}
