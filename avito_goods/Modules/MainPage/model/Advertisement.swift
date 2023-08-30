//
//	MainPageModel.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public struct Advertisement: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String

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
