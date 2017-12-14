//
//  MovieSearchViewModel.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//


protocol MovieSearchViewModeling {
  
    
    typealias RefreshHandlerAlias = () -> Void
    var refresh:RefreshHandlerAlias? { get set}
    func movieCellViewModel(at row:Int) -> MovieTableViewCellViewModeling
    func totalRows() -> Int
    func searchDidPress(with query:String)
    
}

class MovieSearchViewModel:MovieSearchViewModeling {
    
    var refresh: RefreshHandlerAlias?
    

    //MARK:- injected Properties
    fileprivate let movieDataStore:MovieDataStore!
    
    //MARK:- Private properties
    fileprivate var movieDataSource = [MovieDataTransferObject]()
    fileprivate var movieResponseModel : MovieResponseModel?{
        
        didSet{
            
            guard let movies = movieResponseModel?.movies,movies.isEmpty == false else { return }
            
            self.movieDataSource += movies
            
            self.refresh?()
            
        }
    }
    
    //MARK:- Initializer
    
    init(movieDataStore:MovieDataStore) {
        
        self.movieDataStore = movieDataStore
        
    }
    
    //MARK:- MovieSearchViewModeling confirmance
    
    func searchDidPress(with query: String) {
        
        let request = MovieRequestModel(query: "batman", pageNumber: 1)
        
        
        
        movieDataStore.search(with: request) {[weak self] result in
            
            switch result {
                
            case .failure(let error): break
            case .success(let response):
                
                self?.movieResponseModel = response
            }
            
        }
        
    }
    
    func movieCellViewModel(at row:Int) -> MovieTableViewCellViewModeling {
        
        
        return MovieTableViewCellViewModel(movie: movieDataSource[row])
        
    }
    
    func totalRows() -> Int {
     
        return movieDataSource.count
    
    }
    
}
