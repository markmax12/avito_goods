//
//	MainPageCollectionView.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

protocol MainPageCollectionViewDelegate: AnyObject {
    var numberOfItems: Int { get }
    func mainPageCollectionView(collectionView: MainPageCollectionView, didSelectItemAt: String)
    func prepareForReuse(with: ItemCell, at: IndexPath)
    func presentError(error: Error)
}


class MainPageCollectionView: UIView {

    private var collectionView: UICollectionView! = nil
    weak var delegate: MainPageCollectionViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func addRefreshControl(rc: UIRefreshControl) {
        collectionView.refreshControl = rc
    }
}

extension MainPageCollectionView {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
          collectionView.topAnchor.constraint(equalTo: topAnchor),
          collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self)
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
    
    public func configureCellContent(_ cell: ItemCell, _ data: Advertisement) {
        cell.id = data.id
        cell.propagateSubviews(with: data)
    }
}

extension MainPageCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.reuse(ItemCell.self, indexPath)
        delegate?.prepareForReuse(with: cell, at: indexPath)
        return cell
    }
}

extension MainPageCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCell, let id = cell.id else {
            return
        }
        
        delegate?.mainPageCollectionView(collectionView: self, didSelectItemAt: id)
    }
}
