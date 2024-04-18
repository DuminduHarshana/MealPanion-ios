//
//  CoreDataManager.swift
//  finalproj2
//
//  Created by Dumindu Harshana on 2024-04-17.
//

import CoreData

class CoreDataManager {

    // MARK: - Properties

    private let modelName: String

    // MARK: - Core Data Stack

    lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Initialization

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data Saving Support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
