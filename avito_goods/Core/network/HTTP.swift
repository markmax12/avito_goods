//  HTTP.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case HEAD
    case PUT
    case DELETE
    case PATCH
}

public enum HTTPScheme {
    case http
    case https
    case custom(scheme: String)
    
    public var value: String {
        switch self {
            case .http:
                return "http"
            case .https:
                return "https"
            case .custom(let scheme):
                return scheme
        }
    }
}

public struct HTTPHeaders {
    public var headers = [(String, String)]()
    
    public mutating func add(name: String, value: String) {
        self.headers.append((name, value))
    }
}

extension HTTPHeaders: RandomAccessCollection {
    public typealias Element = (name: String, value: String)

    public struct Index: Comparable {
        fileprivate let base: Array<(String, String)>.Index
        public static func < (lhs: Index, rhs: Index) -> Bool {
            return lhs.base < rhs.base
        }
    }

    public var startIndex: HTTPHeaders.Index {
        return .init(base: self.headers.startIndex)
    }

    public var endIndex: HTTPHeaders.Index {
        return .init(base: self.headers.endIndex)
    }

    public func index(before i: HTTPHeaders.Index) -> HTTPHeaders.Index {
        return .init(base: self.headers.index(before: i.base))
    }

    public func index(after i: HTTPHeaders.Index) -> HTTPHeaders.Index {
        return .init(base: self.headers.index(after: i.base))
    }

    public subscript(position: HTTPHeaders.Index) -> Element {
        return self.headers[position.base]
    }
}
