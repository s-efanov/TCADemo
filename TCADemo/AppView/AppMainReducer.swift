import ComposableArchitecture

extension AppReducer {
    @Reducer
    struct MainReducer {
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .destination(.login(.delegate(.onLoginComplete))):
                state.isLoggedIn = true
                return .send(.checkLogin)
            case .destination(.tabs(.settingsTab(.delegate(.onLogout)))):
                state.isLoggedIn = false
                return .send(.checkLogin)
            case .destination:
                return .none
            case .appOnAppear:
                return .send(.checkLogin)
            case .checkLogin:
                if state.isLoggedIn {
                    state.destination = .tabs(TabsReducer.State())
                } else {
                    state.destination = .login(LoginReducer.State())
                }
                return .none
            case .onURLOppened:
                return .none
            }
        }
    }
}
