//
//  CoreDataManager.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 12.09.2021.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func uploadDrink(drink: DrinkComponent)
    func getAllDrinksComponents() -> [DrinkComponentCoreData]
    func takeComponentsOfDrink(with predicate: NSPredicate)  -> [DrinkComponentCoreData]
    func deleteDrink(with drink: DrinkComponent)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    private let entityName = "DrinkCoreData"
    
    private let stack = CoreDataStack()
    
    func uploadDrink(drink: DrinkComponent) {
        
        let backgroundContext = stack.backgroundContext
        backgroundContext.performAndWait {
            let checkDrink = try? fetchRequestForDrink(for: drink).execute()
            if checkDrink?.isEmpty ?? false {
                let _ = DrinkCoreData(context: backgroundContext, with: drink)
            }
            try? backgroundContext.save()
        }
    }
    
    func getAllDrinksComponents() -> [DrinkComponentCoreData] {
        let context = stack.mainContext
        var result = [DrinkComponentCoreData]()
        
        let request = NSFetchRequest<DrinkCoreData>(entityName: entityName)
        context.performAndWait {
            guard let drinks = try? request.execute() else { return }
            result = drinks.map { DrinkComponentCoreData(with: $0) }
        }
        return result
    }
    
    func takeComponentsOfDrink(with predicate: NSPredicate) -> [DrinkComponentCoreData] {
         let context = stack.mainContext
         var result = [DrinkComponentCoreData]()
         
         let request = NSFetchRequest<DrinkCoreData>(entityName: entityName)
         request.predicate = predicate
         context.performAndWait {
             guard let films = try? request.execute() else { return }
             result = films.map { DrinkComponentCoreData(with: $0) }
         }
         return result
     }
    
    func deleteDrink(with drink: DrinkComponent) {
        let backgroundContext = stack.backgroundContext
        backgroundContext.performAndWait {
            if let deleteDrink = try? self.fetchRequestForDrink(for: drink).execute().first {
                backgroundContext.delete(deleteDrink)
            }
            try? backgroundContext.save()
        }
    }
    
}

private extension CoreDataManager {
    private func fetchRequestForDrink(for dto: DrinkComponent) -> NSFetchRequest<DrinkCoreData> {
        let request = NSFetchRequest<DrinkCoreData>(entityName: entityName)
        request.predicate = .init(format: "id == %@", NSNumber(value: dto.id))
        return request
    }
}
