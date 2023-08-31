//
//	ImageCache.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

public final class AssetStore {
    
    //TODO: NOT SURE IF WE NEED ASSET ID OR WE CAN STAY WITH URL AS IT IS NOW
    
    static let placeholderImage = UIImage(named: Placeholder.mainPageAdPlaceholder)!
    
    private var cache: InMemoryCache
    private var networkManager: NetworkManager
    
    init(cache: InMemoryCache = InMemoryCache(), networkManager: NetworkManager) {
        self.cache = cache
        self.networkManager = networkManager
    }
    
    public func fetch(by id: Asset.ID) -> Asset {
        let placeholder = Asset(id: id, image: Self.placeholderImage, isPlaceholder: true)
        
        if let image = cache.fetch(by: id) {
            return image
        }
        
        return placeholder
    }
    //TODO: WORKOUT ERRORS
    public func loadAsset(_ id: Asset.ID, _ completionHandler: (() -> Void)? = nil) async throws {
        let request = GoodsRequest.imageFetch(id: id)
        let data = try await loadImage(request)
        guard let image = UIImage(data: data) else { return }
        let asset = Asset(id: id, image: image, isPlaceholder: false)
        cache.add(asset: asset)
        print("downloaded asset")
        completionHandler?()
    }
    
    private func loadImage(_ request: any RequestProtocol) async throws -> Data {
        return try await networkManager.send(request: request)
    }
}

public enum Placeholder {
    static let mainPageAdPlaceholder = "adPlaceholder"
}
