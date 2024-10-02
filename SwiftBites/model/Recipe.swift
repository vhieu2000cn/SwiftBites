//
//  Ingredient.swift
//  SwiftBites
//
//  Created by admin on 24/9/24.
//

import Foundation
import SwiftData

@Model
final class Recipe: Identifiable, Hashable{
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String
    var summary: String
    var category: Category?
    var serving: Int
    var time: Int
    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.recipe)
    var ingredients: [RecipeIngredient] = []
    var instructions: String
    var imageData: Data?
    
    init ( name: String, summary: String, category: Category?, serving: Int, time: Int, ingredients: [RecipeIngredient], instructions: String, imageData: Data?) {
        self.id = UUID()
        self.name = name
        self.summary = summary
        self.category = category
        self.serving = serving
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
