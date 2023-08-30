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
    
    init(networkManager: any NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    public func itemDetails(for itemID: String) async throws -> ItemDetails {
        let request = GoodsRequest.detailsPage(itemId: itemID)
        return try await networkManager.send(request: request)
    }
}
