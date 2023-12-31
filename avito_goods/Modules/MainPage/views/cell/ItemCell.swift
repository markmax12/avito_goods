//
//	ItemCell.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit
import Kingfisher

final class ItemCell: UICollectionViewCell {
    
    public var id: String?
            
    private var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var itemLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Constants.TextColor.supplementaryContentTextColor
        return label
    }()
    
    private var itemDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Constants.TextColor.supplementaryContentTextColor
        return label
    }()

    lazy private var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemTitle, itemPrice, itemLocation, itemDate])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(Constants.Spacing.mainContentSpacing, after: itemTitle)
        stackView.setCustomSpacing(Constants.Spacing.mainContentSpacing, after: itemPrice)
        stackView.spacing = Constants.Spacing.supplementaryContentSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
        itemTitle.text = nil
        itemPrice.text = nil
        itemLocation.text = nil
        itemDate.text = nil
    }
    
    private func configureSubviews() {
        contentView.addSubviews([itemImage, itemTitle, itemPrice, itemLocation, itemDate])
        
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            itemTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemTitle.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: Constants.Spacing.mainContentSpacing),
            
            itemPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemPrice.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: Constants.Spacing.mainContentSpacing),
            
            itemLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemLocation.topAnchor.constraint(equalTo: itemPrice.bottomAnchor, constant: Constants.Spacing.mainContentSpacing),
            
            itemDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemDate.topAnchor.constraint(equalTo: itemLocation.bottomAnchor, constant: Constants.Spacing.supplementaryContentSpacing),
            itemDate.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    public func propagateSubviews(with data: Advertisement) {
        itemTitle.text = data.title
        itemPrice.text = data.price
        itemLocation.text = data.location
        itemDate.text = data.createdDate
        itemImage.kf.indicatorType = .activity
        itemImage.kf.setImage(with: URL(string: data.imageURL)!)
    }
    
    private enum Constants {
        enum Spacing {
            static let mainContentSpacing: CGFloat = 8
            static let supplementaryContentSpacing: CGFloat = 4
        }
        
        enum TextColor {
            static let supplementaryContentTextColor: UIColor = .systemGray
        }
    }
}
