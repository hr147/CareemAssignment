//
//  MovieTableViewCellViewModel.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/14/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

protocol MovieTableViewCellViewModeling {
    
    var name :String { get }
    var overrivew :String { get }
    var release :String { get }
    var posterPath : String? { get }
    
    
}


struct MovieTableViewCellViewModel:MovieTableViewCellViewModeling {

    
    fileprivate let movie:MovieDataTransferObject!
    
    
    init(movie:MovieDataTransferObject) {
        
        self.movie = movie
    }
    
    
    var name: String { return movie.name }
    var overrivew: String {
        if let _overrivew = movie.description,_overrivew.isEmpty == false  {
            return _overrivew
        }
        return "Movie Overview is not found."
        
    }
    var release: String {
        
        if let _release = movie.releaseDate,_release.isEmpty == false {
            
            return _release
        }
        return "Not found"
        
    }
    var posterPath: String? {return movie.posterFullPath() }
    
    
}
