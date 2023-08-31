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
    case imageFetch(id: String)

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
            case .imageFetch(let id):
                return "s/interns-ios/images/\(id).png"
        }
    }
    
}
