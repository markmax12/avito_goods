//
//	ItemDetailsScrollView.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

protocol InteractiveCommunicationButtonsDelegate: AnyObject {
    
    func didPressEmailButton(email: String?)
    func didPresCallButton(phoneNumber: String?)
}

class ItemDetailsContainer: UIView {
    
    private var credentials: (email: String, phoneNumber: String)?
    
    weak var delegate: (any InteractiveCommunicationButtonsDelegate)?

    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private var itemPriceLabel = UILabel.makeScaledLabel(style: .headline, numberOfLines: 1, scaleFactor: 1.5)
    private var itemTitleLabel = UILabel.makeScaledBoldedLabel(style: .subheadline, scaleFactor: 1.2)
    private var itemLocationLabel = UILabel.makeLabel(style: .body)
    
    private lazy var itemInfoLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemPriceLabel, itemTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.titleAndBodyGroupSpacing
        return stackView
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.callButtonColor
        button.layer.cornerRadius = 10
        button.addAction(UIAction { _ in
            self.didPressCallButton()
        }, for: .touchUpInside)
        return button
    }()
    
    private lazy var emailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Написать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.emailButtonColor
        button.layer.cornerRadius = 10
        button.addAction(UIAction { _ in
            self.didPressEmailButton()
        }, for: .touchUpInside)
        return button
    }()
    
    private lazy var communicationButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [callButton, emailButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private var descritionBodyText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.isEditable = false
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private lazy var itemLocationStackView = UIStackView.titleAndBodyTextContainer(
        title: "Адрес",
        body: itemLocationLabel,
        spacing: Constants.titleAndBodyGroupSpacing)
    
    private lazy var itemDescriptionStackView = UIStackView.titleAndBodyTextContainer(
        title: "Описание",
        body: descritionBodyText,
        spacing: Constants.titleAndBodyGroupSpacing)

    private var itemDatePublishedLabel = UILabel.makeLabel(style: .caption1, textColor: .systemGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didPressEmailButton() {
        delegate?.didPressEmailButton(email: credentials?.email)
    }
    
    private func didPressCallButton() {
        delegate?.didPresCallButton(phoneNumber: credentials?.phoneNumber)
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        addSubviews([
            itemImageView,
            itemInfoLabelsStackView,
            communicationButtonsStackView,
            itemLocationStackView,
            itemDescriptionStackView,
            itemDatePublishedLabel
        ])
        
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            itemImageView.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
            itemImageView.heightAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
            
            itemInfoLabelsStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemInfoLabelsStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemInfoLabelsStackView.topAnchor.constraint(
                equalTo: itemImageView.bottomAnchor,
                constant: Constants.sectionSpacing),
            
            communicationButtonsStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            communicationButtonsStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            communicationButtonsStackView.topAnchor.constraint(
                equalTo: itemInfoLabelsStackView.bottomAnchor,
                constant: Constants.sectionSpacing),
            
            itemLocationStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemLocationStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemLocationStackView.topAnchor.constraint(
                equalTo: communicationButtonsStackView.bottomAnchor,
                constant: Constants.sectionSpacing),
            
            itemDescriptionStackView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            itemDescriptionStackView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            itemDescriptionStackView.topAnchor.constraint(
                equalTo: itemLocationStackView.bottomAnchor,
                constant: Constants.sectionSpacing),
            
            itemDatePublishedLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemDatePublishedLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemDatePublishedLabel.topAnchor.constraint(
                equalTo: itemDescriptionStackView.bottomAnchor,
                constant: Constants.sectionSpacing),
            itemDatePublishedLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
        
    }
    
    public func propagateSubviews(with data: ItemDetails) {
        guard let url = URL(string: data.imageURL) else { return }
        itemImageView.kf.indicatorType = .activity
        itemImageView.kf.setImage(with: url)
        itemPriceLabel.text = data.price
        itemTitleLabel.text = data.title
        itemLocationLabel.text = data.location + ", \(data.address)"
        descritionBodyText.text = data.description
        itemDatePublishedLabel.text = data.createdDate
        credentials = (data.email, data.phoneNumber)
    }
    
    private enum Constants {
        
        enum Colors {
            static let callButtonColor: UIColor = .systemGreen
            static let emailButtonColor: UIColor = .systemBlue
        }
        
        static let sectionSpacing: CGFloat = 20
        static let titleAndBodyGroupSpacing: CGFloat = 8
    }

}
