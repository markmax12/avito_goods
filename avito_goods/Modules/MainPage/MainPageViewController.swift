//
//	MainPageViewController.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

class MainPageViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let tempLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: tempLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - DataSource
    
    typealias CollectionDataSource = UICollectionViewDiffableDataSource<Section, Advertisement>
    typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Section, Advertisement>
    
    enum Section {
        case main
    }
    
    private lazy var dataSource = makeDataSource()
    
    var ads: [Advertisement] = [] {
        didSet {
            applySnapshot()
        }
    }
    var dataFetcherService: any MainPageServiceProtocol
    
    init(dataFetcher: any MainPageServiceProtocol) {
        self.dataFetcherService = dataFetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                ads = try await dataFetcherService.advertisement().advertisements
            } catch {
                print(error.localizedDescription)
            }
            
        }
        configureCollectionView()
        applySnapshot(animatingDifferences: false)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          collectionView.topAnchor.constraint(equalTo: view.topAnchor),
          collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.collectionViewLayout = createLayout()
    }
    
}

extension MainPageViewController {
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = CollectionSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(ads)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> CollectionDataSource {
        collectionView.register(
            ItemCell.self,
            forCellWithReuseIdentifier: ItemCell.reuseIdentifier
        )
        
        return CollectionDataSource(collectionView: collectionView) { collectionView, indexPath, ad in
            let cell = collectionView.reuse(ItemCell.self, indexPath)
            
            Task {
                await cell.propagateSubviews(with: ad)
            }
            
            return cell
        }
    }
}

extension MainPageViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemId = ads[indexPath.row].id
        let config = Network.Config()
        let network = Network(config: config)
        let parser = ResponseDataParser()
        let networkManager = NetworkManager(network: network, parser: parser)
        let itemDetailsFetcherService = ItemDetailsFetcherService(networkManager: networkManager)
        let itemDetailsVC = ItemDetailsViewController(itemDetailsFetcherService: itemDetailsFetcherService)
        itemDetailsVC.itemId = itemId
        navigationController?.pushViewController(itemDetailsVC, animated: true)
    }
}
