//
//  NPResponseModel.swift
//  NailPolishApp
//
//  Created by Haroon Ur Rasheed on 10/15/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//




enum ResultType<T> {
    case success(T)
    case failure(NetworkError)
}

struct DataResponseModel<T> {

     let result:ResultType<T>
    
}

