//
//	Request.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public protocol RequestProtocol {
    
    var method: HTTPMethod { get }
    
    var scheme: HTTPScheme  { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var urlParameters: [URLQueryItem] { get }
    
    var headers: HTTPHeaders { get }
    
    var body: Data? { get }
    
    var timeOutInterval: Double { get }
}

extension RequestProtocol {
    
    public var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    public var urlParameters: [URLQueryItem] {
        return []
    }
    
    public var body: Data? {
        return nil
    }
    
    public var timeOutInterval: Double {
        return 15
    }
}

extension RequestProtocol {
    
    public func buildURL(from request: RequestProtocol) -> URL? {
        var components = URLComponents()
        components.scheme = request.scheme.value
        components.host = request.host
        components.path = request.path
        
        if !request.urlParameters.isEmpty {
            components.queryItems = request.urlParameters
        }
        
        return components.url
    }
    
    public func makeURLRequest() throws -> URLRequest {
        guard let url = buildURL(from: self) else { throw NetworkError.badRequest }
        var urlRequest = URLRequest(url: url, timeoutInterval: timeOutInterval)
        urlRequest.httpMethod = method.rawValue
        
        if headers.isEmpty {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}
