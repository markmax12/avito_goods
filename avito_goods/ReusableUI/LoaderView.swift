//
//	LoaderView.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

final public class LoaderView: UIView {
    
    private var activityIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Constants.viewBackgroundColor
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func startAnimating() {
        activityIndicator.startAnimating()
        isHidden = false
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
    
    private enum Constants {
        static let viewBackgroundColor: UIColor = .white
    }
}
