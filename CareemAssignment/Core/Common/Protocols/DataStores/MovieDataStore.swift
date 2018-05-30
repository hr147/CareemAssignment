//
//  MovieDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import RxSwift

protocol MovieDataStore {
    
    func search(with request:MovieRequestModel , completion: @escaping ResultHandler<MovieResponseModel>)
}

protocol MovieDataStore_Rx {
    func search(with request:MovieRequestModel) -> Observable<MovieResponseModel>
}

