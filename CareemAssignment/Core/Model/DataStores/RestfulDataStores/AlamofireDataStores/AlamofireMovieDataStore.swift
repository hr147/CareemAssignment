//
//  RemoteMovieDataStore.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import RxSwift

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

struct AlamofireMovieDataStore_Rx: MovieDataStore_Rx {
    
    let network:Networking
    let translation:TranslationLayer
    
    func search(with request:MovieRequestModel , completion: @escaping ResultHandler<MovieResponseModel>){
        guard let parameter = try? translation.encode(withModel: request) else { completion(.failure(.RequestFailed)); return  }
        
        let router = RequestRouter.Movie.get(parameters: parameter)
        network.requestObject(router) { (response:DataResponseModel<MovieResponseModel>) in
            completion(response.result)
        }
    }
    
    func search(with request: MovieRequestModel) -> Observable<MovieResponseModel> {
        guard let parameter = try? translation.encode(withModel: request) else { return .error(NetworkError.RequestFailed) }
        
        let router = RequestRouter.Movie.get(parameters: parameter)
        let observable:Observable<ServerResponse<MovieResponseModel>> = network.requestObject(router)
        return observable.map({
            $0.value
        })
    }
}
