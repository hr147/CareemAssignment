//
//  RemoteMovieDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

struct AlamofireMovieDataStore: MovieDataStore {
    let network:Networking
    let translation:TranslationLayer
    
    func search(with request:MovieRequestModel , completion: @escaping ResultHandler<MovieResponseModel>){
        guard let parameter = try? translation.encode(withModel: request) else { completion(.failure(.RequestFailed)); return  }
        
        let router = RequestRouter.Movie.get(parameters: parameter)
        network.requestObject(router) { (response:DataResponseModel<MovieResponseModel>) in
            completion(response.result)
        }
    }
}
