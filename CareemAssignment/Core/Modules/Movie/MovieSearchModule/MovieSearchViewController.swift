//
//  MovieSearchViewController.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    //MARK:- injected Properties
    weak var navigationCoordinator:RootCoordinator!
    var movieViewModel:MovieSearchViewModeling! {
        
        didSet{
            
            self.movieViewModel.refresh = {[unowned self] in
                
                self.movieTableView.reloadData()
                
            }
            
        }
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        movieViewModel.searchDidPress(with: "")
        // Do any additional setup after loading the view.
    }

    //MARK:- User Actions

}


extension MovieSearchViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieViewModel.totalRows()
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                            for: indexPath) as!MovieTableViewCell
        
        let cellModel = movieViewModel.movieCellViewModel(at: indexPath.row)
        
        cell.configure(with: cellModel)
        
        return cell
    }
    
}

