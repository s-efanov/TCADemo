//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by Sergei Efanov on 19.09.2024.
//

import Testing
@testable import TCADemo
import Foundation

@Suite
struct SearchRepoImplTests {
    @Test @MainActor
    func testSuccessDecode() async {
        let repo = SearchRepoImpl()
        let str = """
{ "search" :[{"title": "Встреча1", "type": "calendar"}, {"title": "Пётр Иванов", "type": "person"}]}
"""
        let result = try! repo.decode(data: str.data(using: .utf8)!)
        #expect(
            [
                SearchItem(title: "Встреча1", type: "calendar"),
                SearchItem(title: "Пётр Иванов", type: "person")
            ] == result
        )
    }
    
    @Test @MainActor
    func testErrorDecode() async {
        let repo = SearchRepoImpl()
        let str = """
{"events": ]}
"""
        #expect(throws: NetworkError(), performing: {
            try repo.decode(data: str.data(using: .utf8)!)
        })
    }
}
