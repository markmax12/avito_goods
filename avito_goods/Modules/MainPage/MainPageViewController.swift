//
//	MainPageViewController.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit
import Combine

class MainPageViewController: UIViewController {
    
    private var mainPageViewModel: MainPageViewModel
    private var collectionView: MainPageCollectionView
    private var coordinator: Coordinator
    private var subscriptions = Set<AnyCancellable>()
    
    init(mainPageViewModel: MainPageViewModel,
         collectionView: MainPageCollectionView,
         coordinator: Coordinator) {
        self.mainPageViewModel = mainPageViewModel
        self.collectionView = collectionView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCoordinatorToCollectionView()
        bindViewModelToView()
        setupCollectionView()
        mainPageViewModel.fetchData()
    }
    
    private func setupCollectionView() {
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindCoordinatorToCollectionView() {
        collectionView.delegate = coordinator
    }
    
    private func bindViewModelToView() {
        mainPageViewModel
            .$ads
            .receive(on: DispatchQueue.main)
            .sink { [collectionView] ads in
                collectionView.addModels(ads)
            }.store(in: &subscriptions)
    }
}
