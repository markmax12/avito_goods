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
    @Published var view: ItemDetailsViewState = .loading
    @Published var itemDetails = ItemDetails(id: "", title: "", price: "", location: "", imageURL: "", createdDate: "", description: "", email: "", phoneNumber: "", address: "")

    init(itemDetailsFetcherService: any ItemDetailsFetcherServiceProtocol) {
        self.itemDetailsFetcherService = itemDetailsFetcherService
    }
    
    func fetchData() {
        view = .loading
        Task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            let response = try await itemDetailsFetcherService.itemDetails()
            prepareData(response)
            view = .presenting
        } catch {
            view = .error(error: error)
        }
    }
    
    private func prepareData(_ response: ItemDetails) {
        let formattedPrice = response.price.formatPriceString()
        let formattedDate = "Опубликовано: " + response.createdDate.formattedDate
        itemDetails = ItemDetails(id: response.id, title: response.title, price: formattedPrice, location: response.location, imageURL: response.imageURL, createdDate: formattedDate, description: response.description, email: response.email, phoneNumber: response.phoneNumber, address: response.address)
    }
}
