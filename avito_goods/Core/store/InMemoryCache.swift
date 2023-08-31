//
//	InMemoryCache.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation


protocol Cache {
    
    associatedtype Model: Identifiable
    
    func fetch(by: Model.ID) -> Model?
}

public final class InMemoryCache {
    
    private var queue = DispatchQueue(label: "cache-serial-queue")
    private var cache = [Asset.ID: Asset]()
    
    public func fetch(by id: Asset.ID) -> Asset? {
        queue.sync {
            cache[id]
        }
    }
    
    public func add(asset: Asset) {
        guard !asset.isPlaceholder else { return }
        
        queue.sync {
            cache.removeValue(forKey: asset.id)
            cache[asset.id] = asset
        }
    }
}
