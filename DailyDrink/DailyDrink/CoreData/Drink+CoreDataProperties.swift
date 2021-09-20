//
//  Drink+CoreDataProperties.swift
//  DailyDrinkTests
//
//  Created by Никита Чирухин on 20.09.2021.
//
//

import Foundation
import CoreData


extension DrinkCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrinkCoreData> {
        return NSFetchRequest<DrinkCoreData>(entityName: "DrinkCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var glass: String?
    @NSManaged public var id: Int16
    @NSManaged public var recipe: String?
    @NSManaged public var category: String?
    @NSManaged public var isAlcoholic: Bool

}

extension DrinkCoreData : Identifiable {

}
