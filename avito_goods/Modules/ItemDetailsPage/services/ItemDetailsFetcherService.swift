//
//	ItemDetailsFetcherService.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

protocol ItemDetailsFetcherServiceProtocol {
    
    func itemDetails(for: String) async throws -> ItemDetails
}

public final class ItemDetailsFetcherService: ItemDetailsFetcherServiceProtocol {
    
    let networkManager: any NetworkManagerProtocol
    let itemId: String
    
    init(networkManager: any NetworkManagerProtocol, itemId: String) {
        self.networkManager = networkManager
        self.itemId = itemId
    }
    
    public func itemDetails() async throws -> ItemDetails {
        let request = GoodsRequest.detailsPage(itemId: itemId)
        return try await networkManager.send(request: request)
    }
    
    public func itemDetails(for itemID: String) async throws -> ItemDetails {
        let request = GoodsRequest.detailsPage(itemId: itemID)
        return try await networkManager.send(request: request)
    }
}
