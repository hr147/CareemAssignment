//
//  MovieResponseModel.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//



struct MovieResponseModel:Codable {

    let page:Int
    let totalResults:Int
    let totalPages:Int
    let movies:[MovieDataTransferObject]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
//    page: 1,
//    total_results: 98,
//    total_pages: 5,
}

extension MovieResponseModel {
    static func empty() -> MovieResponseModel {
        return MovieResponseModel(page: 0, totalResults: 0, totalPages: 0, movies: [])
    }
}
