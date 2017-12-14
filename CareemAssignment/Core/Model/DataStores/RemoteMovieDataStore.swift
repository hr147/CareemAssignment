//
//  RemoteMovieDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import Alamofire

enum MovieRouter :APIRoutering {
    
    
    
    case search(MovieRequestModel)
    
    var path: String {
        
        return APIURLs.Paths.movieSearch
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String:Any]?{
        
        switch self {
        case .search(let movieRequestModel):
            
            if let encodedData = try? JSONEncoder().encode(movieRequestModel),
            let jsonModel = try? JSONSerialization.jsonObject(with: encodedData, options:.allowFragments) as? [String: Any]{
                
                return jsonModel
            }
            
            
            //return ["api_key":"2696829a81b1b5827d515ff121700838",
              //      "query":"batman",
                //    "page":1]
        }
        
        return nil
    }
    
}
struct RemoteMovieDataStore: MovieDataStore {
    
     let network:Networking!
    
    func search(with request:MovieRequestModel , completion: @escaping ResultHandler<MovieDataTransferObject>){
        
        let router:MovieRouter = .search(request)
        
        network.requestObject(router) { (response:DataResponseModel<MovieResponseModel>) in
            
            //completion(<#T##ResultType<MovieDataTransferObject>#>)
            
        }
        
    }
    

   
    
    
    
}
