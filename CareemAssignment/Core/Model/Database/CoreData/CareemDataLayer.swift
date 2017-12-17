//
//  CareemDataLayer.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/15/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import CoreData
import Foundation

struct CoreDataFetchRequest {
    
    var isAccending = false
    var sortedKey:String?
    var predicate:NSPredicate?
    var fetchLimit:Int?
    
    
    init() {
        
    }
    
}

protocol CareemDataLayer {
    
    func save(finished: @escaping () -> Void) throws
    func create<T:NSManagedObject>() -> T
    func fetch<T:NSManagedObject>(withRequest request:CoreDataFetchRequest) throws -> [T]
    
}

@available(iOS 10.0, *)
class CoreDataLayer: CareemDataLayer {
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Careem")
        container.viewContext.automaticallyMergesChangesFromParent = true
        //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    
    //MARK:- CareemDataLayer confirmance
    
    func save(finished: @escaping () -> Void) throws {
        
        try mainContext.save()
        
        finished()
        
    }
    
    
    func create<T>() -> T where T : NSManagedObject {
        
        return T(context: mainContext)
        
    }
    
    func fetch<T>(withRequest request: CoreDataFetchRequest) throws -> [T] where T : NSManagedObject {
        
        
        let entityName = String(describing:T.self)
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        
        if let sortedKey = request.sortedKey {
            let sortOn = NSSortDescriptor(key: sortedKey, ascending: request.isAccending)
            fetchRequest.sortDescriptors = [sortOn]
        }
        
        if let predicate = request.predicate {
            fetchRequest.predicate = predicate
        }
        
        if let limit = request.fetchLimit {
            fetchRequest.fetchLimit = limit
        }
        
        
        let spies = try mainContext.fetch(fetchRequest)
        
        return spies
        
    }

    
}


class CoreDataOlderLayer: CareemDataLayer{
    
    fileprivate let objectModelName = "Careem"
    fileprivate let objectModelExtension = "momd"
    fileprivate let dbFilename = "Careem.sqlite"
    fileprivate let appDomain = "com.venturedive.Careem"
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file.
        // This code uses a directory named "com.srmds.<dbName>" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return urls[urls.count-1]
    }()
    
    //
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional.
        // It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: objectModelName, withExtension: objectModelExtension)!
        
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    //Create main context reference, with MainQueueuConcurrency Type.
    lazy var mainManagedObjectContextInstance: NSManagedObjectContext = {
        var mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return mainManagedObjectContext
    }()
    //
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        // The persistent store coordinator for the application. This implementation creates and return a coordinator,
        // having added the store for the application to it. This property is optional since there are legitimate error
        // conditions that could cause the creation of the store to fail.
        
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(dbFilename)
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: self.appDomain, code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            
            abort()
        }
        
        return coordinator
    }()
    
    func save(finished: @escaping () -> Void) throws {
        
        try mainManagedObjectContextInstance.save()
    }
    
    func create<T>() -> T where T : NSManagedObject {
        
        let entityName = String(describing:T.self)
        let entityDesc = NSEntityDescription.entity(forEntityName: entityName, in: mainManagedObjectContextInstance)
        return T(entity: entityDesc!, insertInto: mainManagedObjectContextInstance)
        
    }
    
    func fetch<T>(withRequest request: CoreDataFetchRequest) throws -> [T] where T : NSManagedObject {
        
        let entityName = String(describing:T.self)
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        
        if let sortedKey = request.sortedKey {
            let sortOn = NSSortDescriptor(key: sortedKey, ascending: request.isAccending)
            fetchRequest.sortDescriptors = [sortOn]
        }
        
        if let predicate = request.predicate {
            fetchRequest.predicate = predicate
        }
        
        if let limit = request.fetchLimit {
            fetchRequest.fetchLimit = limit
        }
        
        
        let models = try mainManagedObjectContextInstance.fetch(fetchRequest)
        
        return models
        
    }
    
    
    
}
