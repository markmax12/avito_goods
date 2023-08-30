//
//	UILabelFactory.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

extension UILabel {
    public static func makeLabel(
        style: UIFont.TextStyle,
        numberOfLines: Int = 0,
        textColor: UIColor = .black
    ) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: style)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textColor = textColor
        return label
    }
    
    public static func makeScaledLabel(
        style: UIFont.TextStyle,
        numberOfLines: Int = 0,
        textColor: UIColor = .black,
        scaleFactor: CGFloat
    ) -> UILabel {
        let label = UILabel()
        let font = UIFont.preferredFont(forTextStyle: style)
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        label.font = UIFont(descriptor: descriptor, size: font.pointSize * scaleFactor)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textColor = textColor
        return label
    }
    
    public static func makeScaledBoldedLabel(
        style: UIFont.TextStyle,
        numberOfLines: Int = 0,
        textColor: UIColor = .black,
        scaleFactor: CGFloat,
        bolded: Bool = true
    ) -> UILabel {
        let label = UILabel()
        let font = UIFont.preferredFont(forTextStyle: style)
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        if bolded {
            if let boldedDescriptor = descriptor.withSymbolicTraits(.traitBold) {
                label.font = UIFont(descriptor: boldedDescriptor, size: font.pointSize * scaleFactor)
            } else {
                label.font = UIFont(descriptor: descriptor, size: font.pointSize * scaleFactor)

            }
        }
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textColor = textColor
        return label
    }
}
