//
//  MovieSearchViewModel_Rx.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 5/22/18.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MovieSearchViewModelingInput {
    var query: Driver<String> { get }
    var searchDidTap: Signal<Void> { get }
}

struct MovieSearchViewModelInput:MovieSearchViewModelingInput {
    let query: Driver<String>
    var searchDidTap: Signal<Void>
}

protocol MovieSearchViewModelingOutput {
    var refresh: Driver<Void> { get }
    //    var searchResultLoaded:Driver<Void> { get }
    //    var message:Driver<String> { get }
    //    var savedQueries:Driver<[String]> { get }
    //    var loading:Driver<Bool> { get }
}

struct MovieSearchViewModelOutput:MovieSearchViewModelingOutput {
    let refresh: Driver<Void>
    //    let searchResultLoaded:Driver<Void>
    //    let message:Driver<String>
    //    let savedQueries:Driver<[String]>
    //    let loading:Driver<Bool>
}

protocol MovieSearchViewModeling_Rx {
    func totalRows() -> Int
    subscript(index:Int) -> MovieTableViewCellViewModeling { get }
    func transform(input: MovieSearchViewModelingInput) -> MovieSearchViewModelingOutput
}

class MovieSearchViewModel_Rx:MovieSearchViewModeling_Rx{
    
    fileprivate let movieDataStore:MovieDataStore_Rx
    fileprivate let movies:BehaviorRelay<[MovieDataTransferObject]> = .init(value: [])
    
    init(movieDataStore:MovieDataStore_Rx) {
        self.movieDataStore = movieDataStore
    }
    
    
    func transform(input: MovieSearchViewModelingInput) -> MovieSearchViewModelingOutput {
        let emptyModel = MovieResponseModel(page: 0, totalResults: 0, totalPages: 0, movies: [])
        let result = input.searchDidTap.asObservable()
            .withLatestFrom(input.query)
            .map({
                MovieRequestModel(query: $0, pageNumber: 1)
            })
            .flatMap ({
                self.movieDataStore.search(with: $0)
                    .catchErrorJustReturn(emptyModel)
            })
            .do(onNext: { (model:MovieResponseModel) in
                print(model)
                self.movies.accept(model.movies)
            })
        
        let refresh = result.map({ _ in () }).asDriver(onErrorJustReturn: ())
        
        return MovieSearchViewModelOutput(refresh: refresh)
        
    }
}

extension MovieSearchViewModel_Rx {
    
    func totalRows() -> Int {
        return movies.value.count
    }
    
    subscript(index:Int) -> MovieTableViewCellViewModeling {
        return MovieTableViewCellViewModel(movie: movies.value[index])
    }
}
