//
//  Networking.swift
//  RazeCore
//
//  Created by Yenting Chen on 2022/1/5.
//

import Foundation

extension RazeCore {
    public class Networking {
        
        
        /// Responsible for handling all networking calls
        public class Manager {
            
            public init() {}
            
            private let session = URLSession.shared
            
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                
                let task = session.dataTask(with: url) { data, response, error in
                    
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    
                    completionHandler(result)
                }
                
                task.resume()
                
            }
            
        }
        
    }
    
    public enum NetworkResult<T> {
        case success(T)
        case failure(Error?)
        
    }
}

