//
//  XCTestMainifests.swift
//  RazeCoreTests
//
//  Created by Yenting Chen on 2022/1/5.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    
    return [
        testCase(RazeColorTests.allTests),
        testCasse(NetworkingTests.allTests)
    ]
}
#endif

