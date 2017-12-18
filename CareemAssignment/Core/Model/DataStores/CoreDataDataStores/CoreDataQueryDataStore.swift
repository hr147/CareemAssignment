//
//  CoreDataQueryDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/15/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//


import CoreData


struct CoreDataQueryDataStore: QueryDataStore {
    
    let dataLayer:CareemDataLayer!
    
    func insert(withQuery query:String,finished: @escaping ResultHandler<Bool>){
        
        
        do {
            //fetch query & update its time stamp
            var request = CoreDataFetchRequest()
            request.fetchLimit = 1
            request.predicate = NSPredicate(format: "query == %@", query)
            
            //if it successfull means requested query is already exist & just update with current time stamp
            if let foundQuery:QueryManagedObject = try dataLayer.fetch(withRequest: request).first{
                
                foundQuery.stamp = NSDate()
                
            }else{// if not found create new entry
                
                let queryManagedObject: QueryManagedObject = dataLayer.create()
                queryManagedObject.query = query
                queryManagedObject.stamp = NSDate()
            }
            
            // save into database
            try dataLayer.save {
                
                let result:ResultType<Bool> = .success(true)
                finished(result)
            }
            
        } catch  {
            
            let error:NetworkError = .ServerError(message: "Querey is not saved")
            let result:ResultType<Bool> = .failure(error)
            finished(result)
        }
        
        
    }
    
    func fetchRecentQueries(withTopRecent recent:Int,completion: @escaping ResultHandler<[String]>){
        
        
        func generateError(){
            
            let error:NetworkError = .ServerError(message: "Querey is not found")
            let result:ResultType<[String]> = .failure(error)
            completion(result)
            
        }
        
        
        do {
            //fetch query & update its time stamp
            var request = CoreDataFetchRequest()
            request.fetchLimit = recent
            request.isAccending = false
            request.sortedKey = "stamp"
            
            let queries:[QueryManagedObject] = try dataLayer.fetch(withRequest: request)
            
            if queries.isEmpty {
                
                generateError()
                
            }else{
                
                let queriesString = queries.flatMap({ $0.query })
                
                let result:ResultType<[String]> = .success(queriesString)
                
                completion(result)
                
            }
            
            
            
        } catch  {
            
            generateError()
            
        }
        
    }
    
    
    
}
