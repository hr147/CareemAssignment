//
//  MovieSearchModule_Rx.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 5/22/18.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSearchController_Rx: UIViewController {
    
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
    
    var movieViewModel:MovieSearchViewModeling_Rx!
    
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
        //movieViewModel.searchDidPress(withQuery: qurey)
    }
    
    //MARK:- View Private Methods
    
    private func configureUI() {
        
        //remove extra cells
        movieTableView.tableFooterView = UIView()
        
        //busy indicator configured
        //movieViewModel.loadingHandler?(false)
        
        let input =  MovieSearchViewModelInput(
            query: movieSearchBar.rx.text.orEmpty.asDriver(),
            searchDidTap: movieSearchBar.rx.searchButtonClicked.asSignal())
        
        let output = movieViewModel.transform(input: input)
        
        [output.refresh.drive(movieTableView.rx.reloadData)]
            .forEach({$0.disposed(by: disposeBag)})
        
        
        
        
    }
    private let disposeBag = DisposeBag()
    private func isReachedToLastRow(row:Int) -> Bool {
        
        //        if row == movieViewModel.totalRows()-1 && movieUIActivityIndicatorView.isAnimating == false{
        //
        //            return true
        //        }
        
        return false
        
    }
    
}


extension MovieSearchController_Rx : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieViewModel.totalRows()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                 for: indexPath) as!MovieTableViewCell
        
        let cellViewModel = movieViewModel[indexPath.row]
        cell.configure(with: cellViewModel)
        if isReachedToLastRow(row: indexPath.row) {
            
            //ask view model to load next page if available & callback will refresh UI
            //try? movieViewModel.loadNextPage()
            
        }
        return cell
    }
}

extension MovieSearchController_Rx : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        //inform to viewmodel so that it will callback to show saved suggestions if available
        //movieViewModel.searchDidBegin()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        navigationCoordinator.hidePopupList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //send search query to viewmodel it will validate it & return results or error in callback
        //movieViewModel.searchDidPress(withQuery: searchBar.text)
        searchBar.resignFirstResponder()
        //navigationCoordinator.hidePopupList()
    }
    
    
}

private extension Reactive where Base: UITableView {
    var reloadData: Binder<Void> {
        return Binder(base) { tableView , _ in
            tableView.reloadData()
        }
    }
}
