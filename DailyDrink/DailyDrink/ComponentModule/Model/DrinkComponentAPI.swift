//
//  DrinkComponent.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 02.09.2021.
//

struct DrinkComponentsAPI: Decodable {
    let drinks: [DrinkComponentAPI]
}

struct DrinkComponentAPI: Decodable {
    
    let name: String
    let isAlcoholic: Bool
    let recipe: String
    let imageUrl: String
    let glass: String
    let category: String
    let id: String
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let measure1: String?
    let measure2: String?
    let measure3: String?
    let measure4: String?
    let measure5: String?
    var ingredients: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case isAlcoholic = "strAlcoholic"
        case recipe = "strInstructions"
        case imageUrl = "strDrinkThumb"
        case glass = "strGlass"
        case category = "strCategory"
        case id = "idDrink"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
    }
}

extension DrinkComponentAPI {
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let alcoholic = try container.decode(String.self, forKey: .isAlcoholic)
        isAlcoholic = alcoholic == "Alcoholic"
        recipe = try container.decode(String.self, forKey: .recipe)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        glass = try container.decode(String.self, forKey: .glass)
        category = try container.decode(String.self, forKey: .category)
        id = try container.decode(String.self, forKey: .id)
        ingredient1 = try container.decodeIfPresent(String.self, forKey: .ingredient1)
        ingredient2 = try container.decodeIfPresent(String.self, forKey: .ingredient2)
        ingredient3 = try container.decodeIfPresent(String.self, forKey: .ingredient3)
        ingredient4 = try container.decodeIfPresent(String.self, forKey: .ingredient4)
        ingredient5 = try container.decodeIfPresent(String.self, forKey: .ingredient5)
        measure1 = try container.decodeIfPresent(String.self, forKey: .measure1)
        measure2 = try container.decodeIfPresent(String.self, forKey: .measure2)
        measure3 = try container.decodeIfPresent(String.self, forKey: .measure3)
        measure4 = try container.decodeIfPresent(String.self, forKey: .measure4)
        measure5 = try container.decodeIfPresent(String.self, forKey: .measure5)
    }
}
