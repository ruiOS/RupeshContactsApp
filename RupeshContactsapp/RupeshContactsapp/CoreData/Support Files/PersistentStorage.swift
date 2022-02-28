//
//  PersistentStorage.swift
//  RupeshContactsApp
//
//  Created by rupesh on 28/02/22.
//  Copyright © 2022 rupesh. All rights reserved.
//

import CoreData

final class PersistentStorage {

    static let shared: PersistentStorage = PersistentStorage()

    private init(){}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storageDescription, error in
            if let nsError = error as NSError?{
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        return container
    }()

    lazy var context = persistentContainer.viewContext

    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]{
        do{
            if let result: [T] = try context.fetch(managedObject.fetchRequest()) as? [T] {
                return result
            }
        }catch{
            debugPrint(error)
        }
        return [T]()
    }

    func fetchObjects<T: NSFetchRequestResult & NSManagedObjectEntityProtocol>(
        usingPredicate predicate: NSPredicate? = nil,
        withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil) -> [T]?
    {

        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        if let sortDescriptors = sortDescriptors{
            fetchRequest.sortDescriptors = sortDescriptors
        }

        do {
            return try PersistentStorage.shared.context.fetch(fetchRequest)
        }
        catch{
            debugPrint(error)
        }
        return nil
    }

}
