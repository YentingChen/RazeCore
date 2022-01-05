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
    
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        completionHandler(data, error)
    }
    
    

}

struct MockData: Codable, Equatable {
    var name: String
    var id: String
}

final class RazeNetworkingTests: XCTestCase {
    
    func testSendDataCall() {
        let manager = RazeCore.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        
        let sampleObject = MockData(name: "David", id: "1")
        let data = try? JSONEncoder().encode(sampleObject)
        session.data = data
        let url = URL(fileURLWithPath: "url")
        let expectation = XCTestExpectation(description: "sent data")
        manager.sendData(to: url, body: sampleObject) { result in
            
            expectation.fulfill()
            
            switch result {
                
            case .success(let returnData):
                let returnObject = try? JSONDecoder().decode(MockData.self, from: returnData)
                XCTAssertEqual(returnObject, sampleObject)
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
                
            }
            
        }
        wait(for: [expectation], timeout: 5)
        
    }
    
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

        ("testLoadDataCall", testLoadDataCall),
        ("testSendDataCall", testSendDataCall)
    ]

}
