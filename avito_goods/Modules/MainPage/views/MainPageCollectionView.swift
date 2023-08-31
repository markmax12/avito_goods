//
//	MainPageCollectionView.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

protocol MainPageCollectionViewDelegate: AnyObject {
    func mainPageCollectionView(collectionView: MainPageCollectionView, didSelectItemAt: String)
}


class MainPageCollectionView: UIView {

    typealias CollectionDataSource = UICollectionViewDiffableDataSource<Section.ID, Advertisement.ID>
    typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Section.ID, Advertisement.ID>
    
    struct Section: Identifiable {
        
        enum Identifier: String, CaseIterable {
            case main
        }
        
        var id: Identifier
    }
    
    private var dataSource: CollectionDataSource! = nil
    private var collectionView: UICollectionView! = nil
    private var advertisements: [Advertisement] = []
    private var advertisementStore: ModelStore<Advertisement>
    private var assetStore: AssetStore
    weak var delegate: MainPageCollectionViewDelegate?
    
    init(assetStore: AssetStore, advertisementStore: ModelStore<Advertisement>) {
        self.assetStore = assetStore
        self.advertisementStore = advertisementStore
        super.init(frame: .zero)
        configureCollectionView()
        configureDataSource()
        setInitialSnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addModels(_ models: [Advertisement]) {
        advertisementStore.addModels(models)
        setInitialSnapshot()
    }
}

extension MainPageCollectionView {
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ItemCell, Advertisement.ID> { [weak self] cell, indexPath, adID in
            guard let self = self else { return }
            
            let advertisement = advertisementStore.fetchByID(adID)
            let asset = assetStore.fetch(by: advertisement.id)

            if asset.isPlaceholder {
                Task {
                    let _ = try await self.assetStore.loadAsset(advertisement.id) { [weak self] in
                        guard let self else { return }
                        self.cellNeedsUpdate(adID)
                        print("trying to download an asset")
                   }
                }
            }
            
            cell.propagateSubviews(with: advertisement, asset: asset)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section.ID, Advertisement.ID>(collectionView: collectionView) { (collectionView, indexPath, identifier) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    public func setInitialSnapshot(animatingDifferences: Bool = true) {
        var snapshot = CollectionSnapshot()
        snapshot.appendSections([.main])
        let items = advertisementStore.getIds()
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    public func cellNeedsUpdate(_ id: Advertisement.ID) {
        var snapshot = dataSource.snapshot()
        snapshot.reconfigureItems([id])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MainPageCollectionView {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
          collectionView.topAnchor.constraint(equalTo: topAnchor),
          collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
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

extension MainPageCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let adId = dataSource.itemIdentifier(for: indexPath) else { return }
        let ad = advertisementStore.fetchByID(adId)
        delegate?.mainPageCollectionView(collectionView: self, didSelectItemAt: ad.id)
    }
}
