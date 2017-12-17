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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadNextPage_ShouldLoadNextPageOnAvailablePages() {
        
        let movieDataStore = MorePageResultStubMovieDataStore()// in this reponse contain 2 pages.
        let queryDataStore = StubQueryDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        viewModel.searchDidPress(withQuery: "Batman")
        
        //Apply delay to compelete search process
         sleep(1)
        
        XCTAssertNoThrow(try viewModel.loadNextPage(), "Load next page successfully")
        
        
    }
    
    func testLoadNextPage_ShouldNotLoadNextPageOnPagesEnd() {
        
        let movieDataStore = SuccessResultStubMovieDataStore()// in this reponse only 1 page exist.
        let queryDataStore = StubQueryDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        
        viewModel.searchDidPress(withQuery: "Batman")
        
        //Apply delay to compelete search process
        sleep(1)
        
        XCTAssertThrowsError(try viewModel.loadNextPage(), "Cannot load next page")
        
    }
}
