//
//	MainPageViewState.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

public enum MainPageViewState {
    
    case loading
    case presenting
    case error(error: any Error)
}
