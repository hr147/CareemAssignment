//
//  MovieTableViewCellViewModelTests.swift
//  CareemAssignmentTests
//
//  Created by Haroon Ur Rasheed on 12/18/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import CareemAssignment

class MovieTableViewCellViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOverview_ShouldReturnErrorOnEmptyOverview() {
        
        let movie = MovieDataTransferObject(name: "batman", poster: nil, releaseDate: nil, description: nil)
        let cellViewModel = MovieTableViewCellViewModel(movie: movie)
        
        XCTAssertEqual(cellViewModel.overrivew, "Movie Overview is not found.")
        
    }
    
    func testReleaseDate_ShouldReturnErrorOnEmptyReleaseDate() {
        
        let movie = MovieDataTransferObject(name: "batman", poster: nil, releaseDate: nil, description: nil)
        let cellViewModel = MovieTableViewCellViewModel(movie: movie)
        
        XCTAssertEqual(cellViewModel.release, "Not found")
    }
    
    
    
}
