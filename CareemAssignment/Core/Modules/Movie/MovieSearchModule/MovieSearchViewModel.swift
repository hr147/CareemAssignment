//
//  MovieSearchViewModel.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//


protocol MovieSearchViewModeling {
    
    func searchDidPress(with query:String)
    
}

struct MovieSearchViewModel:MovieSearchViewModeling {

    let movieDataStore:MovieDataStore!
    
    
    //MARK:- MovieSearchViewModeling confirmance
    
    func searchDidPress(with query: String) {
        
        let request = MovieRequestModel(query: "batman", pageNumber: 1)
        
        
        
        movieDataStore.search(with: request) { result in
            
            
        }
        
    }
    
    
    
}
