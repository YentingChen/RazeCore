//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Yenting Chen on 2022/1/5.
//

import XCTest
@testable import RazeCore

class NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var error: Error?
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        completionHandler(data, error)
        
    }

}

final class RazeNetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        let data = Data([0,1,0,1])
        let expectation = XCTestExpectation(description: "Call for data")
        let url = URL(fileURLWithPath: "url")
        session.data = data
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnData):
                
                XCTAssertEqual(returnData, data, "manager returned unexpected data")
                
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
