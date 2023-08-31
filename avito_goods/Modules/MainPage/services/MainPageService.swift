//
//	MainPageService.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

protocol MainPageServiceProtocol {
    func advertisement() async throws -> MainPageResponse
}

final class MainPageService<T: NetworkManagerProtocol>: MainPageServiceProtocol {
    
    let networkManager: T
    
    init(networkManager: T) {
        self.networkManager = networkManager
    }
    
    public func advertisement() async throws -> MainPageResponse {
        let request = GoodsRequest.mainPage
        return try await networkManager.send(request: request)
    }
    
}
