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
    
    func send(request: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void)

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
    
    public func send(request: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let session = config.urlSession
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let error {
                completionHandler(.failure(NetworkError.genericError(error: error)))
            } else {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(.failure(NetworkError.badResponse(responseCode: (response as! HTTPURLResponse).statusCode)))
                    return
                }
                
                if let data {
                    completionHandler(.success(data))
                } else {
                    completionHandler(.failure(NetworkError.badData))
                }
            }
        })
        task.resume()
    }
}
