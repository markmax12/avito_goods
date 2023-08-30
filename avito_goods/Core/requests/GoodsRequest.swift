//
//	MainPageRequest.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

enum GoodsRequest: RequestProtocol {    
    
    case mainPage
    case detailsPage(itemId: String)

    var method: HTTPMethod {
        return .GET
    }
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var host: String {
        return "avito.st"
    }
    
    var path: String {
        switch self {
            case .mainPage:
                return "/s/interns-ios/main-page.json"
            case .detailsPage(let itemId):
                return "/s/interns-ios/details/\(itemId).json"
        }
    }
    
}
