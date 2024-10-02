//
//  ModelContainer.swift
//  SwiftBites
//
//  Created by admin on 24/9/24.
//

import Foundation
import SwiftData
import UIKit

actor SwiftBitesModelContainer {
    typealias ingredients = [Ingredient]
    typealias categories = [Category]
    typealias recipes = [Recipe]
    
    @MainActor
    static func create() -> ModelContainer {
        let schema = Schema([Category.self, Recipe.self, RecipeIngredient.self, Ingredient.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema,configurations: [configuration])
        
        if isEmpty(context: container.mainContext) {
            let (_, _, recipes) = load()
            recipes.forEach { recipe in
                container.mainContext.insert(recipe as Recipe)
            }
        }
        
        return container
    }
    
    private static func isEmpty(context: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<Category>()
        do {
            let existingRecipe = try context.fetch(descriptor)
            return existingRecipe.isEmpty
        } catch {
            return false
        }
    }
    
    // MARK: - Load
    
    private static func load() -> (ingredients, categories, recipes) {
        
        let categories: categories
        
        let recipes: recipes
        
        let ingredients: ingredients
        
        let pizzaDough = Ingredient(name: "Pizza Dough")
        let tomatoSauce = Ingredient(name: "Tomato Sauce")
        let mozzarellaCheese = Ingredient(name: "Mozzarella Cheese")
        let freshBasilLeaves = Ingredient(name: "Fresh Basil Leaves")
        let extraVirginOliveOil = Ingredient(name: "Extra Virgin Olive Oil")
        let salt = Ingredient(name: "Salt")
        let chickpeas = Ingredient(name: "Chickpeas")
        let tahini = Ingredient(name: "Tahini")
        let lemonJuice = Ingredient(name: "Lemon Juice")
        let garlic = Ingredient(name: "Garlic")
        let cumin = Ingredient(name: "Cumin")
        let water = Ingredient(name: "Water")
        let paprika = Ingredient(name: "Paprika")
        let parsley = Ingredient(name: "Parsley")
        let spaghetti = Ingredient(name: "Spaghetti")
        let eggs = Ingredient(name: "Eggs")
        let parmesanCheese = Ingredient(name: "Parmesan Cheese")
        let pancetta = Ingredient(name: "Pancetta")
        let blackPepper = Ingredient(name: "Black Pepper")
        let driedChickpeas = Ingredient(name: "Dried Chickpeas")
        let onions = Ingredient(name: "Onions")
        let cilantro = Ingredient(name: "Cilantro")
        let coriander = Ingredient(name: "Coriander")
        let bakingPowder = Ingredient(name: "Baking Powder")
        let chickenThighs = Ingredient(name: "Chicken Thighs")
        let yogurt = Ingredient(name: "Yogurt")
        let cardamom = Ingredient(name: "Cardamom")
        let cinnamon = Ingredient(name: "Cinnamon")
        let turmeric = Ingredient(name: "Turmeric")
        
        ingredients = [
            pizzaDough,
            tomatoSauce,
            mozzarellaCheese,
            freshBasilLeaves,
            extraVirginOliveOil,
            salt,
            chickpeas,
            tahini,
            lemonJuice,
            garlic,
            cumin,
            water,
            paprika,
            parsley,
            spaghetti,
            eggs,
            parmesanCheese,
            pancetta,
            blackPepper,
            driedChickpeas,
            onions,
            cilantro,
            coriander,
            bakingPowder,
            chickenThighs,
            yogurt,
            cardamom,
            cinnamon,
            turmeric,
        ]
        
        
        
        let italian =  Category(name: "Italian")
        let middleEastern =  Category(name: "Middle Eastern")
        
        let margherita =  Recipe(
            name: "Classic Margherita Pizza",
            summary: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil.",
            category: italian,
            serving: 4,
            time: 50,
            ingredients: [
                RecipeIngredient(ingredient: pizzaDough, quantity: "1 ball"),
                RecipeIngredient(ingredient: tomatoSauce, quantity: "1/2 cup"),
                RecipeIngredient(ingredient: mozzarellaCheese, quantity: "1 cup, shredded"),
                RecipeIngredient(ingredient: freshBasilLeaves, quantity: "A handful"),
                RecipeIngredient(ingredient: extraVirginOliveOil, quantity: "2 tablespoons"),
                RecipeIngredient(ingredient: salt, quantity: "Pinch"),
            ],
            instructions: "Preheat oven, roll out dough, apply sauce, add cheese and basil, bake for 20 minutes.",
            imageData: UIImage(named: "margherita")?.pngData()
        )
        
        let spaghettiCarbonara =  Recipe(
            name: "Spaghetti Carbonara",
            summary: "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
            category: italian,
            serving: 4,
            time: 30,
            ingredients: [
                RecipeIngredient(ingredient: spaghetti, quantity: "400g"),
                RecipeIngredient(ingredient: eggs, quantity: "4"),
                RecipeIngredient(ingredient: parmesanCheese, quantity: "1 cup, grated"),
                RecipeIngredient(ingredient: pancetta, quantity: "200g, diced"),
                RecipeIngredient(ingredient: blackPepper, quantity: "To taste"),
            ],
            instructions: "Cook spaghetti. Fry pancetta until crisp. Whisk eggs and Parmesan, add to pasta with pancetta, and season with black pepper.",
            imageData: UIImage(named: "spaghettiCarbonara")?.pngData()
        )
        
        let hummus =  Recipe(
            name: "Classic Hummus",
            summary: "A creamy and flavorful Middle Eastern dip made from chickpeas, tahini, and spices.",
            category: middleEastern,
            serving: 6,
            time: 10,
            ingredients: [
                RecipeIngredient(ingredient: chickpeas, quantity: "1 can (15 oz)"),
                RecipeIngredient(ingredient: tahini, quantity: "1/4 cup"),
                RecipeIngredient(ingredient: lemonJuice, quantity: "3 tablespoons"),
                RecipeIngredient(ingredient: garlic, quantity: "1 clove, minced"),
                RecipeIngredient(ingredient: extraVirginOliveOil, quantity: "2 tablespoons"),
                RecipeIngredient(ingredient: cumin, quantity: "1/2 teaspoon"),
                RecipeIngredient(ingredient: salt, quantity: "To taste"),
                RecipeIngredient(ingredient: water, quantity: "2-3 tablespoons"),
                RecipeIngredient(ingredient: paprika, quantity: "For garnish"),
                RecipeIngredient(ingredient: parsley, quantity: "For garnish"),
            ],
            instructions: "Blend chickpeas, tahini, lemon juice, garlic, and spices. Adjust consistency with water. Garnish with olive oil, paprika, and parsley.",
            imageData: UIImage(named: "hummus")?.pngData()
        )
        
        let falafel =  Recipe(
            name: "Classic Falafel",
            summary: "A traditional Middle Eastern dish of spiced, fried chickpea balls, often served in pita bread.",
            category: middleEastern,
            serving: 4,
            time: 60,
            ingredients: [
                RecipeIngredient(ingredient: driedChickpeas, quantity: "1 cup"),
                RecipeIngredient(ingredient: onions, quantity: "1 medium, chopped"),
                RecipeIngredient(ingredient: garlic, quantity: "3 cloves, minced"),
                RecipeIngredient(ingredient: cilantro, quantity: "1/2 cup, chopped"),
                RecipeIngredient(ingredient: parsley, quantity: "1/2 cup, chopped"),
                RecipeIngredient(ingredient: cumin, quantity: "1 tsp"),
                RecipeIngredient(ingredient: coriander, quantity: "1 tsp"),
                RecipeIngredient(ingredient: salt, quantity: "1 tsp"),
                RecipeIngredient(ingredient: bakingPowder, quantity: "1/2 tsp"),
            ],
            instructions: "Soak chickpeas overnight. Blend with onions, garlic, herbs, and spices. Form into balls, add baking powder, and fry until golden.",
            imageData: UIImage(named: "falafel")?.pngData()
        )
        
        let shawarma =  Recipe(
            name: "Chicken Shawarma",
            summary: "A popular Middle Eastern dish featuring marinated chicken, slow-roasted to perfection.",
            category: middleEastern,
            serving: 4,
            time: 120,
            ingredients: [
                RecipeIngredient(ingredient: chickenThighs, quantity: "1 kg, boneless"),
                RecipeIngredient(ingredient: yogurt, quantity: "1 cup"),
                RecipeIngredient(ingredient: garlic, quantity: "3 cloves, minced"),
                RecipeIngredient(ingredient: lemonJuice, quantity: "3 tablespoons"),
                RecipeIngredient(ingredient: cumin, quantity: "1 tsp"),
                RecipeIngredient(ingredient: coriander, quantity: "1 tsp"),
                RecipeIngredient(ingredient: cardamom, quantity: "1/2 tsp"),
                RecipeIngredient(ingredient: cinnamon, quantity: "1/2 tsp"),
                RecipeIngredient(ingredient: turmeric, quantity: "1/2 tsp"),
                RecipeIngredient(ingredient: salt, quantity: "To taste"),
                RecipeIngredient(ingredient: blackPepper, quantity: "To taste"),
                RecipeIngredient(ingredient: extraVirginOliveOil, quantity: "2 tablespoons"),
            ],
            instructions: "Marinate chicken with yogurt, spices, garlic, lemon juice, and olive oil. Roast until cooked. Serve with pita and sauces.",
            imageData: UIImage(named: "chickenShawarma")?.pngData()
        )
        
        italian.recipes = [margherita,
                           spaghettiCarbonara]
        middleEastern.recipes = [hummus,
                                 falafel,
                                 shawarma,]
        
         categories = [
            italian,
            middleEastern,
        ]
        
         recipes = [
            margherita,
            spaghettiCarbonara,
            hummus,
            falafel,
            shawarma,
        ]
        return (ingredients, categories, recipes)
    }
    
    enum Error: LocalizedError {
        case ingredientExists
        case categoryExists
        case recipeExists
        
        var errorDescription: String? {
            switch self {
            case .ingredientExists:
                return "Ingredient with the same name exists"
            case .categoryExists:
                return "Category with the same name exists"
            case .recipeExists:
                return "Recipe with the same name exists"
            }
        }
    }
}
