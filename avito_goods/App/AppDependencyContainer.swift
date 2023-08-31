//
//	AppDependencyContainer.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

public final class AppDependencyContainer {
    
    private lazy var networkManager: NetworkManager = {
        let config = Network.Config()
        let network = Network(config: config)
        let parser = ResponseDataParser()
        let networkManager = NetworkManager(network: network, parser: parser)
        return networkManager
    }()
    
    func makeCoordinator() -> Coordinator {
        let navigationController = UINavigationController()
        return Coordinator(appContainer: self, navigationController: navigationController)
    }

    func makeMainPageViewController(coordinator: Coordinator) -> MainPageViewController {
        let mainPageService = MainPageService(networkManager: networkManager)
        let mainPageViewModel = MainPageViewModel(mainPageDataService: mainPageService)
        let collectionView = MainPageCollectionView()
        let loaderView = LoaderView()
        let refreshControl = UIRefreshControl()
        return MainPageViewController(mainPageViewModel: mainPageViewModel, collectionView: collectionView, coordinator: coordinator, loaderView: loaderView, refreshControl: refreshControl)
    }
    
    func makeItemDetailsViewController(id: String, coordinator: Coordinator) -> ItemDetailsViewController {
        let itemDetailsService = ItemDetailsFetcherService(networkManager: networkManager, itemId: id)
        let itemDetailsViewModel = ItemDetailViewModel(itemDetailsFetcherService: itemDetailsService)
        let loaderView = LoaderView()
        return ItemDetailsViewController(viewModel: itemDetailsViewModel, coordinator: coordinator, loaderView: loaderView)
    }
}
