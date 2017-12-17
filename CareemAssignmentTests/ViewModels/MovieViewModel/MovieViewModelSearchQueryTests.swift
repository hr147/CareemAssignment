//
//  MovieViewModelSearchQueryTests.swift
//  CareemAssignmentTests
//
//  Created by Haroon Ur Rasheed on 12/17/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import CareemAssignment

class MovieViewModelSearchQueryTests: XCTestCase {
    
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
    
    
    func testSearchQuery_ShouldShowResultOnSuccess() {
        
        let movieDataStore = SuccessResultStubMovieDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        
        
        viewModel.searchResultLoadedHandler = {
            
            XCTAssertTrue(true)
            
            // Don't forget to fulfill the expectation in the async callback
            expect.fulfill()
        }
        
        viewModel.searchDidPress(withQuery: "Batman")
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    
    func testSearchQuery_ShouldShowAlertOnEmptyQuery() {
        
        let movieDataStore = SuccessResultStubMovieDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        
        viewModel.showAlertHandler = { message in
            
            XCTAssertEqual(message, MovieSearchViewModel.MovieSearchViewModelError.invalidQuery.message)
            
            
            // Don't forget to fulfill the expectation in the async callback
            expect.fulfill()
            
            
        }
        
        viewModel.searchDidPress(withQuery: "")
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    
    
    func testSearchQuery_ShouldShowAlertOnResultNoFound()  {
        
        let movieDataStore = EmptyResultStubMovieDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        
        
        viewModel.showAlertHandler = { message in
            
            XCTAssertEqual(message, MovieSearchViewModel.MovieSearchViewModelError.resultNotFound.message)
            
            
            // Don't forget to fulfill the expectation in the async callback
            expect.fulfill()
            
            
        }
        
        viewModel.searchDidPress(withQuery: "some query witch do not have result")
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            
        }
        
    }
    
    
    func testSearchQuery_ShouldShowAlertOnNetworkIssue() {
        
        let movieDataStore = ErrorResultStubMovieDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        
        
        viewModel.showAlertHandler = { _ in
            
            XCTAssertTrue(true)
            
            
            // Don't forget to fulfill the expectation in the async callback
            expect.fulfill()
            
            
        }
        
        viewModel.searchDidPress(withQuery: "some query witch do not have result")
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            
        }
        
        
    }
    
    
}
