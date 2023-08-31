//
//	ModelStore.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

final class ModelStore<Model: Identifiable> {
    
    private var models = [Model.ID: Model]()
    
    init(_ models: [Model]) {
        self.models = models.groupingByUniqueID()
    }
    
    convenience init() {
        self.init([])
    }
    
    func fetchByID(_ id: Model.ID) -> Model {
        return self.models[id]!
    }
    
    func addModels(_ input: [Model]) {
        input.forEach { models[$0.id] = $0 }
    }
    
    func getIds() -> [Model.ID] {
        return models.keys.map { $0 }
    }
}

extension Sequence where Element: Identifiable {
    
    func groupingByUniqueID() -> [Element.ID: Element] {
        return Dictionary(uniqueKeysWithValues: self.map { ($0.id, $0) })
    }
}
