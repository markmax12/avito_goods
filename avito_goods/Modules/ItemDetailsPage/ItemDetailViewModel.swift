//
//	ItemDetailViewModel.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

final class ItemDetailViewModel {
    
    let itemDetailsFetcherService: any ItemDetailsFetcherServiceProtocol

    init(itemDetailsFetcherService: any ItemDetailsFetcherServiceProtocol) {
        self.itemDetailsFetcherService = itemDetailsFetcherService
    }
}
