//
//  MovieSearchViewController.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var movieUIActivityIndicatorView: UIActivityIndicatorView!
    
    //MARK:- injected Properties
    weak var navigationCoordinator:RootCoordinator!{
        
        didSet{
            
            self.navigationCoordinator.qureyDidSelectHandler = {[unowned self] qurey in
                
                self.setQurey(qurey: qurey)
            }
            
        }
    }
    
    var movieViewModel:MovieSearchViewModeling! {
        
        didSet{
            
            //setup callbacks
            
            // Refresh TableView
            self.movieViewModel.refresh = {[unowned self] in
                
                self.movieTableView.reloadData()
                
            }
            
            //Show Alert Message
            self.movieViewModel.showAlertHandler = {[unowned self] message in
                
                let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
            //Show Saved queies List
            self.movieViewModel.showSavedQueriesHandler = {[unowned self] quries in
                
                self.navigationCoordinator.showPopupList(withDataSource: quries)
                
            }
            
            //Loading progress
            self.movieViewModel.loadingHandler = {[unowned self] isLoading in
                
                if isLoading {
                    
                    self.movieUIActivityIndicatorView.startAnimating()
                    
                }else{
                    
                    self.movieUIActivityIndicatorView.stopAnimating()
                    
                }
                
            }
            
        }
        
    }
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK:- Helper Method
    
    func setQurey(qurey:String)  {
        
        movieSearchBar.text = qurey
        movieSearchBar.resignFirstResponder()
        navigationCoordinator.hidePopupList()
        movieViewModel.searchDidPress(withQuery: qurey)
    }
    
    //MARK:- View Private Methods
    
    private func configureUI() {
        
        //remove extra cells
        movieTableView.tableFooterView = UIView()
        
        //busy indicator configured
        movieViewModel.loadingHandler?(false)
        
    }
    
    private func isReachedToLastRow(row:Int) -> Bool {
        
        if row == movieViewModel.totalRows()-1 && movieUIActivityIndicatorView.isAnimating == false{
            
            return true
        }
        
        return false
        
    }
    
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
        
        
        if isReachedToLastRow(row: indexPath.row) {
            
            //ask view model to load next page if available & callback will refresh UI
            try? movieViewModel.loadNextPage()
            
        }
        
        return cell
    }
    
}

extension MovieSearchViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        //inform to viewmodel so that it will callback to show saved suggestions if available
        movieViewModel.searchDidBegin()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        navigationCoordinator.hidePopupList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //send search query to viewmodel it will validate it & return results or error in callback
        movieViewModel.searchDidPress(withQuery: searchBar.text)
        searchBar.resignFirstResponder()
        navigationCoordinator.hidePopupList()
    }
    
}
