//
//  APIRouterConfiguration.swift
//  Openn
//
//  Created by Haroon Ur Rasheed on 1/22/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import Alamofire

protocol APIRoutering {

    
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: [String:Any]? { get }
    var baseUrl: String { get }
    var httpHeaders: [String : String]? { get }

    
}



extension APIRoutering {

    var baseUrl: String {
        
        return APIURLs.baseURL
        
    }

 
    
    var encoding: Alamofire.ParameterEncoding? {
        
        return URLEncoding.default
        
    }
    
    var httpHeaders: [String : String]? {
        
        return nil
    }
    
    
}


