//
//	MainPageModel.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public struct Advertisement: Codable {
    public let id: String
    public let title: String
    public let price: String
    public let location: String
    public let imageURL: String
    public let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}

extension Advertisement: Equatable {
    public static func == (lhs: Advertisement, rhs: Advertisement) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Advertisement: Hashable { }

extension Advertisement: Identifiable { }
