//
//  DrinkComponentModel.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 16.09.2021.
//
import UIKit

struct DrinkComponent {
    
    let name: String
    let isAlcoholic: Bool
    let glass: String
    let category: String
    let recipe: String
    let id: Int
    var ingredients: [Ingredient] = []
    var image: UIImage = UIImage(named: "drinkShimmer")!
    
    init(drinkComponent: DrinkComponentAPI) {
        self.name = drinkComponent.name
        self.isAlcoholic = drinkComponent.isAlcoholic
        self.glass = drinkComponent.glass
        self.category = drinkComponent.category
        self.recipe = drinkComponent.recipe
        if let id = Int(drinkComponent.id) {
            self.id = id
        } else {
            self.id = 1
        }
        if let ingredient = drinkComponent.ingredient1 {
            if let measure = drinkComponent.measure1 {
                self.ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
            }
        }
        if let ingredient = drinkComponent.ingredient2 {
            if let measure = drinkComponent.measure2 {
                ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
            }
        }
        if let ingredient = drinkComponent.ingredient3 {
            if let measure = drinkComponent.measure3 {
                ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
            }
        }
        if let ingredient = drinkComponent.ingredient4 {
            if let measure = drinkComponent.measure4 {
                ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
            }
        }
        if let ingredient = drinkComponent.ingredient5 {
            if let measure = drinkComponent.measure5 {
                ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
            }
        }
    }
    
    init(drinkComponent: DrinkComponentCoreData) {
        self.name = drinkComponent.name
        self.isAlcoholic = drinkComponent.isAlcoholic
        self.glass = drinkComponent.glass
        self.category = drinkComponent.category
        self.id = drinkComponent.id
        self.recipe = drinkComponent.recipe
    }
    
}

struct Ingredient {
    
    var ingredient: String
    var measure: String
    
    init(ingredient: String, measure: String) {
        self.ingredient = ingredient
        self.measure = measure
    }
}
