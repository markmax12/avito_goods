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
    private var loaderView: LoaderView
    private var refreshControl: UIRefreshControl
    
    init(mainPageViewModel: MainPageViewModel,
         collectionView: MainPageCollectionView,
         coordinator: Coordinator,
         loaderView: LoaderView,
         refreshControl: UIRefreshControl) {
        self.mainPageViewModel = mainPageViewModel
        self.collectionView = collectionView
        self.coordinator = coordinator
        self.loaderView = loaderView
        self.refreshControl = refreshControl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Объявления"
        setupRefreshControler()
        bindToViewState()
        bindCollectionViewToViewModel()
        mainPageViewModel.fetchData()
        collectionView.delegate = self
    }
    
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.frame = view.bounds
    }
    
    private func setupRefreshControler() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.addRefreshControl(rc: refreshControl)
    }
    
        private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
     }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionView()
        setupLoader()
    }
    
    private func bindCollectionViewToViewModel() {
        mainPageViewModel
            .$ads
            .receive(on: DispatchQueue.main)
            .sink { [collectionView, refreshControl] _ in
                refreshControl.endRefreshing()
                collectionView.reloadData()
            }.store(in: &subscriptions)
    }
    
    private func bindToViewState() {
        mainPageViewModel
            .$view
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.respondToStateChange(state: state)
            }.store(in: &subscriptions)
    }
    
    private func respondToStateChange(state: MainPageViewState) {
        switch state {
            case .loading:
                collectionView.isHidden = true
                loaderView.startAnimating()
            case .presenting:
                loaderView.stopAnimating()
                collectionView.isHidden = false
            case .error(let error):
                collectionView.isHidden = true
                present(error) { [collectionView] in
                    collectionView.isHidden = false
                }
        }
    }
    
    @objc
    private func handleRefresh() {
        mainPageViewModel.fetchData()
    }
}

extension MainPageViewController: MainPageCollectionViewDelegate {
    
    var numberOfItems: Int {
        return mainPageViewModel.ads.count
    }
    
    func mainPageCollectionView(collectionView: MainPageCollectionView, didSelectItemAt id: String) {
        coordinator.pushItemDetailsController(with: id)
    }
    
    func prepareForReuse(with cell: ItemCell, at indexPath: IndexPath) {
        let item = mainPageViewModel.ads[indexPath.row]
        collectionView.configureCellContent(cell, item)
    }
    
    func presentError(error: Error) {
        present(error, nil)
    }
}
