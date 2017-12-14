//
//  JSONTranslation.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/14/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import Alamofire

protocol TranslationLayer {
    
    func json<T:Codable>(withModel model:T) throws -> [String:Any]?
    
}

class JSONTranslation:TranslationLayer {
   
    
    func json<T>(withModel model: T) throws -> [String : Any]? where T : Decodable, T : Encodable {
        
        let encodedData = try JSONEncoder().encode(model)
        
        return try JSONSerialization.jsonObject(with: encodedData, options:.allowFragments) as? [String: Any]
    }

    
}
