//
//	ItemDetailsScrollView.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

class ItemDetailsContainer: UIView {

    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.setContentCompressionResistancePriority(.defaultLow - 100, for: .vertical)
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    private var itemPriceLabel = UILabel.makeScaledLabel(style: .headline, numberOfLines: 1, scaleFactor: 2)
    private var itemTitleLabel = UILabel.makeScaledLabel(style: .subheadline, scaleFactor: 2)
    private var itemLocationLabel = UILabel.makeLabel(style: .footnote)
    
    private lazy var itemInfoLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemPriceLabel, itemTitleLabel, itemLocationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()
    
    private var callButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.callButtonColor
        button.layer.cornerRadius = 10
        //TODO: Implement call pop-up
        return button
    }()
    
    private var emailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Написать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.emailButtonColor
        button.layer.cornerRadius = 10
        //TODO: Implement email pop-up
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
        textView.isEditable = false
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private lazy var itemDescriptionStackView: UIStackView = {
        let descriptionTitleLabel = UILabel.makeLabel(style: .headline)
        descriptionTitleLabel.text = "Описание"
        
        let stackView = UIStackView(arrangedSubviews: [descriptionTitleLabel, descritionBodyText])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.titleAndBodyGroupSpacing
        return stackView
    }()

    private var itemDatePublishedLabel = UILabel.makeLabel(style: .caption1, textColor: .systemGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureSubviews() {
        backgroundColor = .white
        addSubviews([
            itemImageView,
            itemInfoLabelsStackView,
            communicationButtonsStackView,
            itemDescriptionStackView,
            itemDatePublishedLabel
        ])
        
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            itemImageView.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 0.5),
            
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
            
            itemDescriptionStackView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            itemDescriptionStackView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            itemDescriptionStackView.topAnchor.constraint(
                equalTo: communicationButtonsStackView.bottomAnchor,
                constant: Constants.sectionSpacing),
            
            itemDatePublishedLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemDatePublishedLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemDatePublishedLabel.topAnchor.constraint(
                equalTo: itemDescriptionStackView.bottomAnchor,
                constant: Constants.sectionSpacing),
            itemDatePublishedLabel.bottomAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    public func propagateSubviews(with data: ItemDetails) async {
        print("propagating data")
        itemPriceLabel.text = data.price
        itemTitleLabel.text = data.title
        itemLocationLabel.text = data.location + ", \(data.address)"
        descritionBodyText.text = data.description
        itemDatePublishedLabel.text = "Опубликовано: " + data.createdDate
        await itemImageView.loadImagefromURLIfNeeded(data.imageURL)
    }
    
    private enum Constants {
        
        enum Colors {
            static let callButtonColor: UIColor = .systemGreen
            static let emailButtonColor: UIColor = .systemBlue
        }
        
        static let sectionSpacing: CGFloat = 20
        static let titleAndBodyGroupSpacing: CGFloat = 2
    }

}
