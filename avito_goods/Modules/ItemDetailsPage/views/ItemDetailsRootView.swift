//
//	ItemDetailsRootView.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

class ItemDetailsRootView: UIView {

    private var containerView = ItemDetailsContainer(frame: .zero)
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    //TODO: SCROLL VIEW IS NOT WORKING PROPERLY
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    //TODO: REMOVE THIS IN SUBCLASS IF HAVE TIME
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            frameGuide.topAnchor.constraint(equalTo: topAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentGuide.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            contentGuide.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor)
        ])
    }
    
    public func propagateView(with data: ItemDetails) async {
        await containerView.propagateSubviews(with: data)
    }
}
