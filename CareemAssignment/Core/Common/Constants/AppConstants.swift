//
//  AppConstants.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

struct APIURLs {
    
    static let baseURL = "http://api.themoviedb.org/3/"
    
    struct Paths {
        
        static let movieSearch = "search/movie"
    }
    
}


struct DependencyNames {
    
    static let remoteMovieDataStore = String(describing:RemoteMovieDataStore.self)
    
}
