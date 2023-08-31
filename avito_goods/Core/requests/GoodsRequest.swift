//
//	MainPageRequest.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public enum GoodsRequest: RequestProtocol {
    
    case mainPage
    case detailsPage(itemId: String)

    public var method: HTTPMethod {
        return .GET
    }
    
    public var scheme: HTTPScheme {
        return .https
    }
    
    public var host: String {
        return "avito.st"
    }
    
    public var path: String {
        switch self {
            case .mainPage:
                return "/s/interns-ios/main-page.json"
            case .detailsPage(let itemId):
                return "/s/interns-ios/details/\(itemId).json"
        }
    }
    
}
