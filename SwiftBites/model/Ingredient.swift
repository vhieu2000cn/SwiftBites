//
//  Ingredient.swift
//  SwiftBites
//
//  Created by admin on 24/9/24.
//

import Foundation
import SwiftData

@Model
final class Ingredient: Identifiable, Hashable{
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String
    
    init( name: String) {
        self.id = UUID()
        self.name = name
    }
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id
    }
}
