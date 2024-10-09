import Testing
@testable import TCADemo
import ComposableArchitecture

@Suite
struct LoginReducerTests {
    @Test @MainActor
    func onEnterButtonTappedValidLogin() async {
        let store = TestStore(initialState: LoginReducer.State(login: "123", password: "123")) {
            LoginReducer()
        }
        
        await store.send(.onEnterButtonTapped)
        await store.receive(.delegate(.onLoginComplete))
    }
}
