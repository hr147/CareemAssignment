//
//  AppRootCoordinator.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit


protocol RootCoordinator: class {
    
    var qureyDidSelectHandler:((String)->Void)? { get set }
    func showPopupList(withDataSource data:[String])
    func hidePopupList()
    
}


class AppRootCoordinator: RootCoordinator {
    
    
    var qureyDidSelectHandler: ((String) -> Void)?
    
    fileprivate var rootViewController: MovieSearchViewController
    
    init(with rootViewController: MovieSearchViewController) {
        
        self.rootViewController = rootViewController
        
    }
    
    var menuTableViewController:MenuTableViewController?
    
    
    func showPopupList(withDataSource data:[String]){
        
        menuTableViewController = MenuTableViewController()
        menuTableViewController?.dataSource = data
        menuTableViewController?.menuItemSelectedHandler = {[weak self] selectedItem in
            
            self?.qureyDidSelectHandler?(selectedItem)

        }
        
        
        if let queryTableView = menuTableViewController?.tableView {
            
            let searchBarFrame = rootViewController.movieSearchBar.frame
            
            rootViewController.view.addSubview(queryTableView)
            rootViewController.view.bringSubview(toFront: queryTableView)
            
            queryTableView.frame = CGRect(x: searchBarFrame.origin.x,
                                          y: searchBarFrame.origin.y + searchBarFrame.height,
                                          width: searchBarFrame.size.width,
                                          height: queryTableView.contentSize.height)
            
            
        }
        
        
    }
    
    
    func hidePopupList() {
        
        menuTableViewController?.tableView.removeFromSuperview()
        menuTableViewController = nil
        
    }
    
}
