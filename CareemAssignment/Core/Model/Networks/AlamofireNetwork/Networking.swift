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

import RxSwift

protocol Networking {
    func requestObject<T:Decodable>(_ request: RequestConverterProtocol,completionHandler: @escaping DataResponseHandler<T>)
    
    func requestObject<T:Decodable>(_ request: RequestConverterProtocol) -> Observable<ServerResponse<T>>
}


