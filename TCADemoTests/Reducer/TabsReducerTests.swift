import Testing
@testable import TCADemo
import ComposableArchitecture

@Suite
struct TabsReducerTests {
    @Test @MainActor
    func onTapClear() async {
        let store = TestStore(initialState: TabsReducer.State()) {
            TabsReducer()
        }

        await store.send(.settingsTab(.delegate(.onLogout)))
    }
}
