//
//  Networking.swift
//  RazeCore
//
//  Created by Yenting Chen on 2022/1/5.
//

import Foundation

protocol NetworkSession {
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) 
}

extension URLSession: NetworkSession {
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        let task = dataTask(with: url) { data, _, error in
            
            completionHandler(data, error)
        }
        
        task.resume()
        
    }
    
    
}

extension RazeCore {
    
    public class Networking {
        
        /// Responsible for handling all networking calls
        public class Manager {
            
            public init() {}
            
            internal var session: NetworkSession = URLSession.shared
            
            /// Calls to the live internet to retrieve Data from a specific location
            /// - Parameters:
            ///   - url: The location you wish to fetch data from
            ///   - completionHandler: Returns a result object which signifies the status of the request
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                
                session.get(from: url) { data, error in
                    
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    
                    completionHandler(result)
                }
                
                
            }
            
        }
        
    }
    
    public enum NetworkResult<T> {
        
        case success(T)
        
        case failure(Error?)
        
    }
    
}

