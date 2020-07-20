//
//  CoreDataModel.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 19/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import Foundation
import CoreData

class CoreDataModel {
    
    private lazy var privateManageedContext : NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private(set) lazy var managedContext : NSManagedObjectContext = {
           var managedObjectContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
           managedObjectContext.parent = self.privateManageedContext
           return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "Favorites", withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "Favorites.sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()

    
    func saveContext(){
        managedContext.perform {
            if self.managedContext.hasChanges{
                do{
                    try self.managedContext.save()
                    self.privateManageedContext.perform{
                        do{
                            try self.privateManageedContext.save()
                            debugPrint("Check2")
                        }
                        catch{
                            let error =  error as Error
                            debugPrint("\(error.localizedDescription)")
                            fatalError("Private managedContext")
                        }
                    }
                    debugPrint("Check")
                }
                catch {
                    let error =  error as Error
                    debugPrint("\(error.localizedDescription)")
                    fatalError("Done")
                }
            }
        }
        debugPrint("")

    }
}
