//
//  MovieSearchViewController.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    //MARK:- injected Properties
    weak var navigationCoordinator:RootCoordinator!
    var movieViewModel:MovieSearchViewModeling! {
        
        didSet{
            
            
        }
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        movieViewModel.searchDidPress(with: "")
        // Do any additional setup after loading the view.
    }

    //MARK:- User Actions

}
