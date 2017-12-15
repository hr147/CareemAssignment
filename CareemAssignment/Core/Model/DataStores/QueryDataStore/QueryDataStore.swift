//
//  QueryDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/15/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

protocol QueryDataStore {

    
    func insert(withQuery query:String,finished: @escaping ResultHandler<Bool>)
    func fetchRecentQueries(withTopRecent recent:Int,completion: @escaping ResultHandler<[String]>)
    
}
