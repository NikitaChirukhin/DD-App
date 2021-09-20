//
//  CoreDataStack.swift
//  DailyDrink
//
//  Created by Никита Чирухин on 20.09.2021.
//

import Foundation
import CoreData

final class CoreDataStack {

    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext

    private let objectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "DailyDrink", withExtension: "momd") else {
            fatalError("CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("CoreData MOMD is nil")
        }
        return model
    }()

    private let coordinator: NSPersistentStoreCoordinator

    init() {

        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("Documents is nil")
        }
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("DailyDrink.sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)

        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                              configurationName: nil,
                                              at: url,
                                              options: [NSMigratePersistentStoresAutomaticallyOption: true,
                                                        NSInferMappingModelAutomaticallyOption: true])
        } catch {
            fatalError()
        }

        self.coordinator = coordinator
        self.mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.mainContext.persistentStoreCoordinator = coordinator

        self.backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.backgroundContext.persistentStoreCoordinator = coordinator

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.backgroundContext)
    }

}

private extension CoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            mainContext.performAndWait {
                mainContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}
