//
//  DeeplinkManager.swift
//  TCADemo
//
//  Created by Sergei Efanov on 22.09.2024.
//

import ComposableArchitecture
import Foundation

extension AppReducer {
    @Reducer
    struct DeeplinkReducer {
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case let .onURLOppened(url):
                guard state.isLoggedIn else { return .none }
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return .none }
                
                switch components.host {
                case "swiftui":
                    return resolveSwiftUI(state: &state, components: components)
                case "uikit":
                    return resolveUIKit(state: &state, components: components)
                default:
                    return .none
                }
            default:
                return .none
            }
        }
        
        func resolveSwiftUI(state: inout State, components: URLComponents) -> Effect<Action> {
            switch components.path {
            case "counter":
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .swiftUI,
                        swiftUITab: SwiftUITabReducer.State(
                            path: StackState<SwiftUITabPath.State>([.swiftUICounter(SwiftUICounterReducer.State())])
                        )
                    )
                )
                return .none
            case "weather":
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .swiftUI,
                        swiftUITab: SwiftUITabReducer.State(
                            path: StackState<SwiftUITabPath.State>([.swiftUIWeather(SwiftUIWeatherReducer.State())])
                        )
                    )
                )
                return .none
            default:
                return .none
            }
        }
        
        func resolveUIKit(state: inout State, components: URLComponents) -> Effect<Action> {
            switch components.path {
            case "counter":
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .uiKit,
                        uiKitTab: UIKitTabReducer.State(
                            path: StackState<UIKitTabPath.State>([.uiKitCounter(UIKitCounterReducer.State())])
                        )
                    )
                )
                return .none
            case "weather":
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .uiKit,
                        uiKitTab: UIKitTabReducer.State(
                            path: StackState<UIKitTabPath.State>([.uiKitWeather(UIKitWeatherReducer.State())])
                        )
                    )
                )
                return .none
            default:
                return .none
            }
        }
    }
}
