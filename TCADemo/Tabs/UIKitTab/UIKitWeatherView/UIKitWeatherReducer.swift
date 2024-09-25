import ComposableArchitecture

@Reducer
struct UIKitWeatherReducer {
    @Dependency(\.weatherRepo) var weatherRepo
    
    enum Action: Equatable {
        case onAppear
        case onSuccess(Double)
        case onError
    }
    
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
        var temperature: Double?
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            state.isLoading = true
            return .run { send in
                do {
                    try await send(.onSuccess(weatherRepo.get()))
                } catch {
                    await send(.onError)
                }
            }
        case let .onSuccess(value):
            state.isLoading = false
            state.temperature = value
            return .none
        case .onError:
            state.isLoading = false
            return .none
        }
    }
}
