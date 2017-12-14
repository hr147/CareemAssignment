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
    var posterPath : String { get }
    
    
}


struct MovieTableViewCellViewModel:MovieTableViewCellViewModeling {

    
    fileprivate let movie:MovieDataTransferObject!
    
    
    init(movie:MovieDataTransferObject) {
        
        self.movie = movie
    }
    
    
    var name: String { return movie.name }
    var overrivew: String {return movie.description}
    var release: String {return movie.releaseDate}
    var posterPath: String {return movie.poster }
    
    
}
