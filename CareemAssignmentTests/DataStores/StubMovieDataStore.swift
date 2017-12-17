//
//  StubMovieDataStore.swift
//  CareemAssignmentTests
//
//  Created by Haroon Ur Rasheed on 12/17/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
@testable import CareemAssignment

//MARK:- Stubs
class SuccessResultStubMovieDataStore: MovieDataStore {
    
    func search(with request: MovieRequestModel, completion: @escaping (ResultType<MovieResponseModel>) -> Void) {
        
        let movie1 = MovieDataTransferObject(name: "movie1",
                                             poster: "poster1",
                                             releaseDate: "1/12/1999",
                                             description: "description1")
        
        let movie2 = MovieDataTransferObject(name: "movie2",
                                             poster: "poster2",
                                             releaseDate: "2/12/1999",
                                             description: "description2")
        
        let movie3 = MovieDataTransferObject(name: "movie3",
                                             poster: "poster3",
                                             releaseDate: "3/12/1999",
                                             description: "description3")
        
        let movies = [movie1,movie2,movie3]
        
        let response = MovieResponseModel(page: 1,
                                          totalResults: movies.count,
                                          totalPages: 1,
                                          movies: movies)
        
        let result:ResultType<MovieResponseModel> = .success(response)
        
        completion(result)
        
        
    }
    
}

class MorePageResultStubMovieDataStore: MovieDataStore {
    
    func search(with request: MovieRequestModel, completion: @escaping (ResultType<MovieResponseModel>) -> Void) {
        
        let movie1 = MovieDataTransferObject(name: "movie1",
                                             poster: "poster1",
                                             releaseDate: "1/12/1999",
                                             description: "description1")
        
        let movie2 = MovieDataTransferObject(name: "movie2",
                                             poster: "poster2",
                                             releaseDate: "2/12/1999",
                                             description: "description2")
        
        let movie3 = MovieDataTransferObject(name: "movie3",
                                             poster: "poster3",
                                             releaseDate: "3/12/1999",
                                             description: "description3")
        
        let movies = [movie1,movie2,movie3]
        
        let response = MovieResponseModel(page: 1,
                                          totalResults: movies.count,
                                          totalPages: 2,
                                          movies: movies)
        
        let result:ResultType<MovieResponseModel> = .success(response)
        
        completion(result)
        
        
    }
    
}

class EmptyResultStubMovieDataStore: MovieDataStore {
    
    func search(with request: MovieRequestModel, completion: @escaping (ResultType<MovieResponseModel>) -> Void) {
        
        
        
        let movies = [MovieDataTransferObject]()
        
        let response = MovieResponseModel(page: 0,
                                          totalResults: movies.count,
                                          totalPages: 0,
                                          movies: movies)
        
        let result:ResultType<MovieResponseModel> = .success(response)
        
        completion(result)
        
        
    }
    
}


class ErrorResultStubMovieDataStore: MovieDataStore {
    
    func search(with request: MovieRequestModel, completion: @escaping (ResultType<MovieResponseModel>) -> Void) {
        
        
        let error:NetworkError = .ServerError(message: "Something went wrong or network issue")
        let result:ResultType<MovieResponseModel> = .failure(error)
        
        completion(result)
        
        
    }
    
}
