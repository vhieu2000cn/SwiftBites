//
//  Category.swift
//  SwiftBites
//
//  Created by admin on 24/9/24.
//

import Foundation
import SwiftData

@Model
final class Category: Identifiable, Hashable {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Recipe.category)
    var recipes: [Recipe]
    
    init(name: String , recipes: [Recipe] = []) {
        self.id = UUID()
        self.name = name
        self.recipes = recipes
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}


