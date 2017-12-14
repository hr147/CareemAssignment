//
//  MovieDataTransferObject.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import Foundation

struct MovieDataTransferObject:Codable {

    let name:String
    let poster:String
    let releaseDate:String
    let description:String
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case description = "overview"
    }
    
}
