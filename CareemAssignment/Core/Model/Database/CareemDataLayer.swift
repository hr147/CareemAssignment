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
    
    //    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil, completion: (([T]) -> ())) {
    //        var objects = self.realm?.objects(model as! Object.Type)
    //
    //        if let predicate = predicate {
    //            objects = objects?.filter(predicate)
    //        }
    //
    //        if let sorted = sorted {
    //            objects = objects?.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
    //        }
    //
    //        completion(objects.flatMap { $0 as? T })
    //    }
    
    
}
