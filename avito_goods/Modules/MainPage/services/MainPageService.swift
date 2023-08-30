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

final public class MainPageService: MainPageServiceProtocol {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func advertisement() async throws -> MainPageResponse {
        let request = GoodsRequest.mainPage
        return try await networkManager.send(request: request)
    }
    
}
