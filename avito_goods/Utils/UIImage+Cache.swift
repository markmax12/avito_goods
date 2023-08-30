//
//	UIImage+Cache.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

extension UIImageView {
    func loadImagefromURLIfNeeded(
        _ url: String,
        with placeholder: UIImage? = UIImage(named: Placeholder.mainPageAdPlaceholder)
    ) async {
        let cache = URLCache.shared
        guard let url = URL(string: url) else { self.image = placeholder; return }
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            let response = try? await URLSession.shared.data(for: request)
            
            guard let (data, response) = response,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let image = UIImage(data: data) else {
                return
            }
            
            let cachedResponse = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedResponse, for: request)
            await MainActor.run { self.image = image }
        }
        
    }
    
    
    public enum Placeholder {
        static let mainPageAdPlaceholder = "adPlaceholder"
    }
}


