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
struct CalendarRepoImplTests {
    @Test @MainActor
    func testSuccessDecode() async {
        let repo = CalendarRepoImpl()
        let str = """
{"events": [{"title":"Встреча1", "from": "10:15", "to": "11:00"},{"title":"Встреча2", "from": "15:00", "to": "16:00"}]}
"""

        let result = try! repo.decode(data: str.data(using: .utf8)!)
        #expect(
            [
                CalendarItem(title: "Встреча1", from: "10:15", to: "11:00"),
                CalendarItem(title: "Встреча2", from: "15:00", to: "16:00")
            ] == result
        )
    }
    
    @Test @MainActor
    func testErrorDecode() async {
        let repo = CalendarRepoImpl()
        let str = """
{"events": ]}
"""
        #expect(throws: NetworkError(), performing: {
            try repo.decode(data: str.data(using: .utf8)!)
        })
    }
}
