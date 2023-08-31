//
//	Error.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public enum NetworkError: Error {
    case badResponse(responseCode: Int)
    case badRequest
    case noResponse
    case badData
    case genericError(error: Error)
    case noConnection
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .badResponse(responseCode: let responseCode):
                let localizedResponse = HTTPURLResponse.localizedString(forStatusCode: responseCode)
                return NSLocalizedString("Bad response, code: \(localizedResponse)", comment: "")
            case .badData:
                return NSLocalizedString("Can't parse data or server sent corrupted data", comment: "")
            case .noResponse:
                return NSLocalizedString("Request timeout", comment: "")
            case .badRequest:
                return NSLocalizedString("Can't make URL from request", comment: "")
            case .noConnection:
                return NSLocalizedString("No internet conntection", comment: "")
            case .genericError:
                return NSLocalizedString("Network Error", comment: "")
        }
    }
}
