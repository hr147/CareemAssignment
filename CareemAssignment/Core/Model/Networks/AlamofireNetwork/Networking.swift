//
//  Networking.swift
//  Audalize
//
//  Created by Haroon Ur Rasheed on 3/24/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//



//import ObjectMapper

typealias DataResponseHandler<T> = (DataResponseModel<T>) -> Void
typealias ResultHandler<T> = (ResultType<T>) -> Void

protocol Networking {
    

    func requestObject<T:Codable>(_ router: APIRoutering,completionHandler: @escaping DataResponseHandler<T>)
    
    //func requestArray<T:Mappable>(_ router: APIRoutering,completionHandler: @escaping NPResponseHandler<[T]>)
    
}


