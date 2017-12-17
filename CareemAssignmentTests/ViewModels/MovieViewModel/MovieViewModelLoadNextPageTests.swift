//
//  MovieViewModelLoadNextPageTests.swift
//  CareemAssignmentTests
//
//  Created by Haroon Ur Rasheed on 12/17/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import CareemAssignment

class MovieViewModelLoadNextPageTests: XCTestCase {
    
    var queryDataStore:QueryDataStore!
    
    override func setUp() {
        super.setUp()
        queryDataStore = EmptyStubQueryDataStore()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadNextPage_ShouldLoadNextPageOnAvailablePages() {
        
        let movieDataStore = MorePageResultStubMovieDataStore()// in this reponse contain 2 pages.
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        viewModel.searchDidPress(withQuery: "Batman")
                
        XCTAssertNoThrow(try viewModel.loadNextPage(), "Load next page successfully")
        
        
    }
    
    func testLoadNextPage_ShouldNotLoadNextPageOnPagesEnd() {
        
        let movieDataStore = SuccessResultStubMovieDataStore()// in this reponse only 1 page exist.
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        viewModel.searchDidPress(withQuery: "Batman")
    
        XCTAssertThrowsError(try viewModel.loadNextPage(), "Cannot load next page")
        
    }
}
