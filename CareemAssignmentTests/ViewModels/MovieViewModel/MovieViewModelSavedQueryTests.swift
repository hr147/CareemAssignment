//
//  MovieViewModelSavedQueryTests.swift
//  CareemAssignmentTests
//
//  Created by Haroon Ur Rasheed on 12/17/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import CareemAssignment

class MovieViewModelSavedQueryTests: XCTestCase {
    
    var movieDataStore = SuccessResultStubMovieDataStore()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSavedQuery_ShouldShowSavedQuries() {
        
        let queryDataStore = DataStubQueryDataStore()
        let viewModel = MovieSearchViewModel(movieDataStore: movieDataStore, queryDataStore: queryDataStore)
        
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        //only callback when 1 or more quiries found
        viewModel.showSavedQueriesHandler = { quries in
            
            XCTAssertTrue(true)
        
            expect.fulfill()
            
        }
        
        viewModel.searchDidBegin()
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    
    
    
}
