//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Yenting Chen on 2022/1/5.
//

import XCTest
@testable import RazeCore

final class RazeNetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let expectation = XCTestExpectation(description: "Call for data")
        guard let url = URL(string: "https://raywechlich.com") else {
            return XCTFail("Could not create URL properly")
        }
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnData):
                print(returnData)
                XCTAssertNotNil(returnData, "Response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
            
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    static var allTests = [

        ("testLoadDataCall", testLoadDataCall)
    ]

}
