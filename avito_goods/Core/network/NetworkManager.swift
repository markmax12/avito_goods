//  
//	NetworkManager.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

protocol NetworkManagerProtocol {
    
    var network: NetworkProtocol { get }
    
    var parser: ResponseDataParserProtocol { get }
    
    func send<Response: Decodable>(request: RequestProtocol) async throws -> Response
}

final public class NetworkManager: NetworkManagerProtocol {
    
    var network: any NetworkProtocol
    var parser: any ResponseDataParserProtocol
    
    init(
        network: any NetworkProtocol,
        parser: any ResponseDataParserProtocol
    ) {
        self.network = network
        self.parser = parser
    }
    
    public func send<Response: Decodable>(request: RequestProtocol) async throws -> Response {
        let urlRequest = try request.makeURLRequest()
        let data = try await network.send(request: urlRequest)
        let parsedResponse: Response = try parser.parse(networkData: data)
        return parsedResponse
    }
}
