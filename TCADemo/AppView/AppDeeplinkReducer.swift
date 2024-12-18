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
            let queryItems = components.queryItems
            switch components.path {
            case "/profile":
                guard let title = queryItems?.first(where: { $0.name == "title" })?.value else { return .none }
                guard let type = queryItems?.first(where: { $0.name == "type" })?.value else { return .none }
                
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .swiftUI,
                        swiftUITab: SearchReducer.State(
                            path: StackState<TabPath.State>([
                                .profile(ProfileReducer.State(searchItem: SearchItem(
                                    title: title,
                                    type: type
                                )))
                            ])
                        )
                    )
                )
                return .none
            case "/event":
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .swiftUI,
                        swiftUITab: SearchReducer.State(
                            path: StackState<TabPath.State>([
                                .event(EventReducer.State(calendarItem: CalendarItem(title: "Event", from: "10:00", to: "11:00")))
                            ])
                        )
                    )
                )
                return .none
            default:
                return .none
            }
        }
        
        func resolveUIKit(state: inout State, components: URLComponents) -> Effect<Action> {
            let queryItems = components.queryItems
            
            switch components.path {
            case "/profile":
                guard let title = queryItems?.first(where: { $0.name == "title" })?.value else { return .none }
                guard let type = queryItems?.first(where: { $0.name == "type" })?.value else { return .none }
                
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .uiKit,
                        uiKitTab: SearchReducer.State(
                            path: StackState<TabPath.State>([
                                .profile(ProfileReducer.State(searchItem: SearchItem(title: title, type: type)))
                            ])
                        )
                    )
                )
                return .none
            case "/event":
                state.destination = .tabs(
                    TabsReducer.State(
                        currentTab: .uiKit,
                        uiKitTab: SearchReducer.State(
                            path: StackState<TabPath.State>([
                                .event(EventReducer.State(calendarItem: CalendarItem(title: "Event", from: "10:00", to: "11:00")))
                            ])
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
