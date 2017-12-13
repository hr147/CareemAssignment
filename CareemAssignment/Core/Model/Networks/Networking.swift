//
//  Networking.swift
//  Audalize
//
//  Created by Haroon Ur Rasheed on 3/24/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//



//import ObjectMapper


protocol Networking {
    
    typealias DataResponseHandler<T> = (DataResponseModel<T>) -> Void
    typealias ResultHandler<T> = (ResultType<T>) -> Void

    //func requestObject<T:Mappable>(_ router: APIRoutering,completionHandler: @escaping NPResponseHandler<T>)
    
    //func requestArray<T:Mappable>(_ router: APIRoutering,completionHandler: @escaping NPResponseHandler<[T]>)
    
}


