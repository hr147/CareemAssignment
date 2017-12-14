//
//  MovieDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

protocol MovieDataStore {
    
    func search(with request:MovieRequestModel , completion: @escaping ResultHandler<MovieDataTransferObject>)
}

