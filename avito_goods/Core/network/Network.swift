//
//	Network.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

protocol NetworkProtocol {
        
    func send(request: URLRequest) async throws -> Data
}

public final class Network: NetworkProtocol {
    
    public final class Config {
        
        public let urlSession: URLSession
        
        init(urlSession: URLSession) {
            self.urlSession = urlSession
        }
        
        convenience init() {
            self.init(urlSession: URLSession.shared)
        }
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    public func send(request: URLRequest) async throws -> Data {
        let urlSession = config.urlSession
        let (data, response) = try await urlSession.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            let responseCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.badResponse(responseCode: responseCode)
        }
        
        return data
    }
}
