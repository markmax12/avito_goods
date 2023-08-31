//
//	MainPageViewModel.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation
import Combine

final class MainPageViewModel {
    
    var mainPageDataService: MainPageServiceProtocol
    @Published var ads = [Advertisement]()
    
    init(mainPageDataService: MainPageServiceProtocol) {
        self.mainPageDataService = mainPageDataService
    }
    
    func fetchData() {
        Task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            let response = try await mainPageDataService.advertisement()
            prepareData(response)
        } catch {
            //show error
        }
    }
    
    private func prepareData(_ response: MainPageResponse) {
        ads = response.advertisements.map { ad in
            let price = ad.price.formatPriceString()
            //TODO: DATE FORMATTING
            return Advertisement(
                id: ad.id,
                title: ad.title,
                price: price,
                location: ad.location,
                imageURL: ad.imageURL,
                createdDate: ad.createdDate)
        }
    }
}
