//
//  DrinkCoreData+CoreDataClass.swift
//  DailyDrink
//
//  Created by Никита Чирухин on 20.09.2021.
//
//

import Foundation
import CoreData

@objc(DrinkCoreData)
public class DrinkCoreData: NSManagedObject {
    convenience init(context: NSManagedObjectContext, with drink: DrinkComponent) {
        self.init(context: context)
        self.name = drink.name
        self.glass = drink.glass
        self.category = drink.category
        self.isAlcoholic = drink.isAlcoholic
        self.id = Int16(drink.id)
        self.recipe = drink.recipe
    }
}
