//
//  JSONTranslation.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/14/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import Alamofire

enum TranslationLayerError:Error {
    case encodingFailed
}

protocol TranslationLayer {
    func encode<T:Encodable>(withModel model:T) throws -> [String:Any]
    func decode<T:Decodable>(withData data:Data) throws -> T
}

class JSONTranslation:TranslationLayer {
    
    func encode<T>(withModel model: T) throws -> [String : Any] where T : Encodable {
        let encodedData = try JSONEncoder().encode(model)
        if let encoded = try JSONSerialization.jsonObject(with: encodedData, options:.allowFragments) as? [String : Any] {
            return encoded
        }
        throw TranslationLayerError.encodingFailed
    }
    
    func decode<T>(withData data: Data) throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
