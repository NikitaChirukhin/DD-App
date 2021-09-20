//
//  Drinks.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 21.08.2021.
//

import UIKit

struct Drinks: Decodable {
    var drinks: [Drink]
}

struct Drink: Decodable {
    var name: String
    var id: String
    var imageId: String
    var image: Data?
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case id = "idDrink"
        case imageId = "strDrinkThumb"
    }
}

extension Drink {
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        imageId = try container.decode(String.self, forKey: .imageId)
    }
}
