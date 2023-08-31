//
//	UIViewController+.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

extension UIViewController {
    
    public func present(_ error: Error, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
