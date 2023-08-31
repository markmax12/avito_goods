//
//	ResponseDataParser.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

protocol ResponseDataParserProtocol {
    func parse<Response: Decodable>(networkData: Data) throws -> Response
}

final public class ResponseDataParser: ResponseDataParserProtocol {
    
    private var decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func parse<Response: Decodable>(networkData: Data) throws -> Response {
        return try decoder.decode(Response.self, from: networkData)
    }
}
