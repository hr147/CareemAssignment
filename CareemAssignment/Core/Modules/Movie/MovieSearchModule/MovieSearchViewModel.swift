//
//  MovieSearchViewModel.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//


protocol MovieSearchViewModeling {
    
    
    typealias RefreshHandlerAlias = () -> Void
    var refresh:RefreshHandlerAlias? { get set }
    
    typealias SearchResultLoadedHandlerAlias = () -> Void
    var searchResultLoadedHandler:SearchResultLoadedHandlerAlias? { get set }
    
    typealias ShowAlertHandlerAlias = (String) -> Void
    var showAlertHandler:ShowAlertHandlerAlias? { get set }
    
    typealias ShowSavedQueriesHandlerAlias = ([String]) -> Void
    var showSavedQueriesHandler:ShowSavedQueriesHandlerAlias? { get set }
    
    typealias LoadingHandlerAlias = (Bool) -> Void
    var loadingHandler:LoadingHandlerAlias? { get set }
    
    func searchDidBegin()
    func movieCellViewModel(at row:Int) -> MovieTableViewCellViewModeling
    func totalRows() -> Int
    func searchDidPress(withQuery query:String?)
    func loadNextPage() throws
    
}

class MovieSearchViewModel:MovieSearchViewModeling {
    
    
    enum MovieSearchViewModelError:Error{
        
        case invalidQuery
        case resultNotFound
        case noMorePageExist
        
        var message:String {
            
            switch self {
            case .invalidQuery: return "Please enter valid query"
            case .resultNotFound: return "Result not found please try differnt query!"
            case .noMorePageExist: return "No more pages exist"
                
            }
        }
        
        
        
    }
    
    //MARK:- injected Properties
    fileprivate let movieDataStore:MovieDataStore!
    fileprivate let queryDataStore:QueryDataStore!
    
    //MARK:- Properties
    var refresh: RefreshHandlerAlias?
    var showAlertHandler: ShowAlertHandlerAlias?
    var loadingHandler: LoadingHandlerAlias?
    var showSavedQueriesHandler: ShowSavedQueriesHandlerAlias?
    var searchResultLoadedHandler: SearchResultLoadedHandlerAlias?
    fileprivate var movieDataSource = [MovieDataTransferObject]()
    fileprivate var currentPage = 0
    fileprivate var totalPage = 0
    fileprivate var query:String = ""
    
    
    //MARK:- Initializer
    
    init(movieDataStore:MovieDataStore,queryDataStore:QueryDataStore) {
        
        self.movieDataStore = movieDataStore
        self.queryDataStore = queryDataStore
        
    }
    
    //MARK:- Private methods
    
    
    private func generateRequest(withQuery query:String?) throws -> MovieRequestModel {
        
        guard let _query = query, _query.isEmpty == false else {
            throw MovieSearchViewModelError.invalidQuery
            
        }
        
        let nextPage = currentPage + 1
        
        self.query = _query
        
        return MovieRequestModel(query: _query, pageNumber: nextPage)
        
    }
    
    
    func canLoadNextPage() -> Bool {
        
        if currentPage >= totalPage {
            
            return false
        }
        
        return true
    }
    
    //MARK:- MovieSearchViewModeling confirmance
    
    func loadNextPage() throws {
        
        if canLoadNextPage() == false {
            throw MovieSearchViewModelError.noMorePageExist
        }
        
        fetchMovies(with: query)
        
        
    }
    
    func searchDidPress(withQuery query:String?) {
        
        //reset paging information
        totalPage = 1
        currentPage = 0
        
        //Removing all prviously search record & refresh UI
        movieDataSource.removeAll()
        refresh?()
        
        
        //Search movies against query & save it in db 
        fetchMovies(with: query) {[weak self] movies in
            
            if movies.isEmpty == false {
                self?.saveQuery()
                self?.searchResultLoadedHandler?()
            }
        }
        
    }
    
    
    
    
    
    func movieCellViewModel(at row:Int) -> MovieTableViewCellViewModeling {
        
        
        return MovieTableViewCellViewModel(movie: movieDataSource[row])
        
    }
    
    func totalRows() -> Int {
        
        return movieDataSource.count
        
    }
    
    func searchResult(withMovies movies:[MovieDataTransferObject],page:Int,totalPages:Int)  {
        
        
        if movies.isEmpty {
            
            showAlertHandler?(MovieSearchViewModelError.resultNotFound.message)
            return
        }
        
        //Append movies result
        movieDataSource += movies
        
        //update paging info
        totalPage = totalPages
        currentPage = page
        
        //refresh UI for new records
        refresh?()
        
    }
    
}



//MARK:- Data Stores
extension MovieSearchViewModel{
    
    func searchDidBegin() {
        
        
        queryDataStore.fetchRecentQueries(withTopRecent: 10) {[weak self] result in
            
            switch result {
                
            case .failure(let error):
                print(error.description)
            case .success(let quries):
                
                if quries.isEmpty == false{
                    
                    self?.showSavedQueriesHandler?(quries)
                }
            }
            
        }
    }
    
    
    func fetchMovies(with query: String?,completion:(([MovieDataTransferObject])->Void)? = nil) {
        
        do {
            
            let request = try generateRequest(withQuery: query)
            
            loadingHandler?(true)
            movieDataStore.search(with: request) {[weak self] result in
                
                self?.loadingHandler?(false)
                switch result {
                    
                case .failure(let error):
                    
                    self?.showAlertHandler?(error.description)
                    
                case .success(let response):
                    
                    self?.searchResult(withMovies: response.movies,
                                       page: response.page,
                                       totalPages: response.totalPages)
                    
                    completion?(response.movies)
                }
                
            }
        } catch  let error as MovieSearchViewModelError {
            
            showAlertHandler?(error.message)
            
        } catch {
            
            showAlertHandler?("Some thing went wrong")
        }
        
        
    }
    
    func saveQuery() {
        
        queryDataStore.insert(withQuery: query) { result in
            
            switch result {
                
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.description)
            }
            
        }
        
    }
    
}
