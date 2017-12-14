//
//  MovieRequestModel.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//



struct MovieRequestModel:Codable {

    //api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1
    
    let apiKey:String = APPKeys.APIKeys.themoviedb
    let query:String
    let pageNumber:Int
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case query
        case pageNumber = "page"
    }
    
}
