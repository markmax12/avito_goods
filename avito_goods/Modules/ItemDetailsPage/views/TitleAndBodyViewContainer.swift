//
//	TitleAndBodyViewContainer.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

public protocol TextBasedViewProtocol: UIView { }

extension UILabel: TextBasedViewProtocol { }
extension UITextView: TextBasedViewProtocol { }

extension UIStackView {
    public static func titleAndBodyTextContainer<T: TextBasedViewProtocol>(
        title: String,
        body: T,
        spacing: CGFloat
    ) -> UIStackView {
        let titleLabel = UILabel.makeScaledLabel(style: .headline, scaleFactor: 1.2)
        titleLabel.text = title
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, body])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        return stackView
    }
}
