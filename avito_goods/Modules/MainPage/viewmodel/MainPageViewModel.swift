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
    @Published var view: MainPageViewState = .loading
    
    init(mainPageDataService: MainPageServiceProtocol) {
        self.mainPageDataService = mainPageDataService
    }
    
    func fetchData() {
        Task {
            view = .loading
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            let response = try await mainPageDataService.advertisement()
            prepareData(response)
            view = .presenting
        } catch {
            view = .error(error: error)
        }
    }
    
    private func prepareData(_ response: MainPageResponse) {
        ads = response.advertisements.map { ad in
            let price = ad.price.formatPriceString()
            let formattedDate = ad.createdDate.formattedDate
            return Advertisement(
                id: ad.id,
                title: ad.title,
                price: price,
                location: ad.location,
                imageURL: ad.imageURL,
                createdDate: formattedDate)
        }
    }
}
