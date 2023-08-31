//
//	ItemDetailsViewState.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public enum ItemDetailsViewState {
    case loading
    case presenting
    case error(error: Error)
}
