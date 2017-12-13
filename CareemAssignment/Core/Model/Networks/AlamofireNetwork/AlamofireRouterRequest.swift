//
//  AlamofireNetworkRequest.swift
//  Audalize
//
//  Created by Haroon Ur Rasheed on 3/24/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireRouterRequest: URLRequestConvertible {

    
    let router: APIRoutering!
    
    
    
    init(_ router:APIRoutering ) {
        
        self.router = router
    
    }
    
    
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: router.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(router.path))
        urlRequest.httpMethod = router.method.rawValue
        
        
        router.httpHeaders?.forEach { key , value in
        
            urlRequest.setValue(value, forHTTPHeaderField: key)
            
        }
        
        if let encoding = router.encoding {
            print(router.parameters as Any)
            return try encoding.encode(urlRequest, with: router.parameters)
            
        }
        
        
        return urlRequest
        
        
    }

    
}
