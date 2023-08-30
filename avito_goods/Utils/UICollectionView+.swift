//
//	UICollectionView+.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func reuse <T: UICollectionViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
