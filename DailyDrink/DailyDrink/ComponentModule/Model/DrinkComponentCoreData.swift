//
//  DrinkComponentCoreData.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 16.09.2021.
//

import Foundation

struct DrinkComponentsCoreData: Decodable {
    let drinks: [DrinkComponentCoreData]
}

struct DrinkComponentCoreData: Decodable {
    
    let name: String
    let isAlcoholic: Bool
    let glass: String
    let category: String
    let id: Int
    let recipe: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case isAlcoholic
        case glass
        case category
        case id
        case recipe
    }
    
    init(with drink: DrinkCoreData) {
        self.name = drink.name ?? "Default"
        self.category = drink.category ?? "Default"
        self.isAlcoholic = drink.isAlcoholic
        self.id = Int(drink.id)
        self.glass = drink.glass ?? "Default"
        self.recipe = drink.recipe ?? "Default"
    }
}
