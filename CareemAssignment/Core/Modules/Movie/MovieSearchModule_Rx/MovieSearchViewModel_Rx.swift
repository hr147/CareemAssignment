//
//  MovieSearchViewModel_Rx.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 5/22/18.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import RxSwift
import RxCocoa

struct ListPager {
    
}

protocol MovieSearchViewModelingInput {
    var query: Driver<String> { get }
    var searchDidTap: Signal<Void> { get }
    var loadNextPage: Signal<Void> { get }
}

struct MovieSearchViewModelInput:MovieSearchViewModelingInput {
    let query: Driver<String>
    let searchDidTap: Signal<Void>
    let loadNextPage: Signal<Void>
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
    fileprivate let movieResponse:BehaviorRelay<MovieResponseModel?> = .init(value: nil)
    
    init(movieDataStore:MovieDataStore_Rx) {
        self.movieDataStore = movieDataStore
    }
    
    
    func transform(input: MovieSearchViewModelingInput) -> MovieSearchViewModelingOutput {
        
       let nextPage =  input.loadNextPage.asObservable()
                        .withLatestFrom(movieResponse)
                        .filter({
                            $0!.totalPages > $0!.page
                        })
                        .map({ _ in })
        
        
        let search = input.searchDidTap.asObservable()
                    .do(onNext: {
                        self.movieResponse.accept(nil)
                        self.movies.accept([])
                    })
        
        
        
        let result = Observable.merge(nextPage,search)
            .withLatestFrom(input.query)
            .filter({
                $0.isEmpty == false
            })
            .map({
                let page = ( self.movieResponse.value?.page ?? 0 ) + 1
                return MovieRequestModel(query: $0, pageNumber: page)
            })
            .flatMap ({
                return self.movieDataStore.search(with: $0)
                    .catchErrorJustReturn(MovieResponseModel.empty())
            })
            .do(onNext: { (model:MovieResponseModel) in
                print(model)
                self.movieResponse.accept(model)
                let movies = self.movies.value + model.movies
                self.movies.accept(movies)
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
