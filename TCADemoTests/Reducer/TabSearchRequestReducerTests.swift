//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by Sergei Efanov on 19.09.2024.
//

import Testing
@testable import TCADemo
import ComposableArchitecture

@Suite
struct TabSearchRequestReducerTests {
    @Test @MainActor
    func success() async {
        let requestMock = SearchRepoMock(
            result: .success([SearchItem(title: "Title", type: "type")])
        )
        
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer.SearchRequestReducer()
        } withDependencies: {
            $0.searchRepo = requestMock
        }

        await store.send(.searchRequest(.start))
        await store.receive(.searchRequest(.onSuccess(
            [SearchItem(title: "Title", type: "type")]
        )))
    }
    
    @Test @MainActor
    func failure() async {
        let requestMock = SearchRepoMock(
            result: .failure(NetworkError())
        )
        
        let store = TestStore(initialState: TabReducer.State()) {
            TabReducer.SearchRequestReducer()
        } withDependencies: {
            $0.searchRepo = requestMock
        }

        await store.send(.searchRequest(.start))
        await store.receive(.searchRequest(.onError(
            NetworkError()
        )))
    }
}
