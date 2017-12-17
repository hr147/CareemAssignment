//
//  StubQueryDataStore.swift
//  CareemAssignmentTests
//
//  Created by Haroon Ur Rasheed on 12/17/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
@testable import CareemAssignment

class StubQueryDataStore: QueryDataStore {

    func insert(withQuery query: String, finished: @escaping (ResultType<Bool>) -> Void) {
        
        
    }
    
    
    func fetchRecentQueries(withTopRecent recent: Int, completion: @escaping (ResultType<[String]>) -> Void) {
        
        
    }
}
