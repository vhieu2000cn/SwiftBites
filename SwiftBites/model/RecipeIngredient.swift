//
//  Ingredient.swift
//  SwiftBites
//
//  Created by admin on 24/9/24.
//

import Foundation
import SwiftData

@Model
final class RecipeIngredient: Identifiable, Hashable{
    @Attribute(.unique)
    var id: UUID
    var ingredient: Ingredient
    var quantity: String
    var recipe: Recipe?
    
    init (ingredient: Ingredient, quantity: String){
        self.id = UUID()
        self.ingredient = ingredient
        self.quantity = quantity
    }
    
    static func == (lhs: RecipeIngredient, rhs: RecipeIngredient) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
