//
//  MovieDataTransferObject.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import Foundation

struct MovieDataTransferObject:Codable {

    enum MovieImageSize:String {
        case w92 = "w92"
        case w185 = "w185"
        case w500 = "w500"
        case w780 = "w780"
    }
    
    let name:String
    let poster:String?
    let releaseDate:String?
    let description:String?
    
    func posterFullPath(withImageSize size:MovieImageSize = .w92) -> String? {
        
        guard let path = poster else { return nil }
        
        return APIURLs.imageBaseURL + size.rawValue + path
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case description = "overview"
    }
    
}
