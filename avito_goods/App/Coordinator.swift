//
//	Coordinator.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit
import Combine

public final class Coordinator {
    
    var appContainer: AppDependencyContainer
    var navigationController: UINavigationController
    
    init(appContainer: AppDependencyContainer, navigationController: UINavigationController) {
        self.appContainer = appContainer
        self.navigationController = navigationController
    }
    
    public func embedInitialViewController(initialViewController: UIViewController) {
        navigationController.viewControllers.append(initialViewController)
    }
}

extension Coordinator: MainPageCollectionViewDelegate {
    func mainPageCollectionView(collectionView: MainPageCollectionView, didSelectItemAt id: String) {
        let itemDetailViewController = appContainer.makeItemDetailsViewController(id: id, coordinator: self)
        navigationController.pushViewController(itemDetailViewController, animated: true)
    }
}

extension Coordinator {
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
