//
//	UIView+.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

extension UIView {
    
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
