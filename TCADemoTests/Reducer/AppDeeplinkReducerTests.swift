//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by Sergei Efanov on 19.09.2024.
//

import Testing
@testable import TCADemo
import ComposableArchitecture
import Foundation

@Suite
struct AppDeeplinkReducerTests {
    @Test @MainActor
    func swiftUIProfileNoLogin() async {
        let store = TestStore(initialState: AppReducer.State()) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://swiftui/profile?title=Roman&type=person")!))
    }
    
    @Test @MainActor
    func swiftUIProfileNoType() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://swiftui/profile?title=Roman")!))
    }
    
    @Test @MainActor
    func swiftUIProfileNoTitle() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://swiftui/profile?type=person")!))
    }
    
    @Test @MainActor
    func uiKitProfileNoType() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://uikit/profile?title=Roman")!))
    }
    
    @Test @MainActor
    func uiKitProfileNoTitle() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://uikit/profile?type=person")!))
    }
    
    @Test @MainActor
    func swiftUIProfile() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://swiftui/profile?title=Roman&type=person")!)) { state in
            state.destination = .tabs(TabsReducer.State(
                currentTab: .swiftUI,
                swiftUITab: SearchReducer.State(
                    path: StackState<TabPath.State>([
                        .profile(ProfileReducer.State(searchItem: SearchItem(title: "Roman", type: "person")))
                    ])
                )
            ))
        }
    }

    @Test @MainActor
    func swiftUIEvent() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://swiftui/event?title=Ev&from=a&to=b")!)) { state in
            state.destination = .tabs(TabsReducer.State(
                currentTab: .swiftUI,
                swiftUITab: SearchReducer.State(
                    path: StackState<TabPath.State>([
                        .event(EventReducer.State(calendarItem: CalendarItem(title: "Event", from: "10:00", to: "11:00")))
                    ])
                )
            ))
        }
    }
    
    @Test @MainActor
    func swiftUISome() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://swiftui/some")!))
    }
    
    @Test @MainActor
    func uiKitProfile() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://uikit/profile?title=Roman&type=person")!)) { state in
            state.destination = .tabs(TabsReducer.State(
                currentTab: .uiKit,
                uiKitTab: SearchReducer.State(
                    path: StackState<TabPath.State>([
                        .profile(ProfileReducer.State(searchItem: SearchItem(title: "Roman", type: "person")))
                    ])
                )
            ))
        }
    }
    
    @Test @MainActor
    func uiKitEvent() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://uikit/event?title=Ev&from=a&to=b")!)) { state in
            state.destination = .tabs(TabsReducer.State(
                currentTab: .uiKit,
                uiKitTab: SearchReducer.State(
                    path: StackState<TabPath.State>([
                        .event(EventReducer.State(calendarItem: CalendarItem(title: "Event", from: "10:00", to: "11:00")))
                    ])
                )
            ))
        }
    }
    
    @Test @MainActor
    func uiKitSome() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "tcademo://uikit/some")!))
    }
    
    @Test @MainActor
    func notValidURL() async {
        let store = TestStore(initialState: AppReducer.State(isLoggedIn: Shared(true))) {
            AppReducer.DeeplinkReducer()
        }
        
        await store.send(.onURLOppened(URL(string: "abc")!))
    }
}
