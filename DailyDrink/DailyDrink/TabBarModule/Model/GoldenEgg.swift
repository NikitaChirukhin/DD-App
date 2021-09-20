//
//  GoldenEgg.swift
//  DailyDrink
//
//  Created by Никита Чирухин on 20.09.2021.
//

import Foundation

struct GoldenEgg {
    
    let userName = UserDefaults.standard
    
    static func setName(name: String) {
        UserDefaults.standard.set(name, forKey: "userName")
    }
    static func getName() -> String {
        let name = UserDefaults.standard.object(forKey: "userName") as? String ?? ""
        return name
    }
}
