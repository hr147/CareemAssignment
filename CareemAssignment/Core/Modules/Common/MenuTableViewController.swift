//
//  QueryTableViewController.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/16/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit


class MenuTableViewController: UITableViewController {
    
    let cellIdentifier = String(describing:UITableViewCell.self)
    var dataSource = [String]()
    var menuItemSelectedHandler:((String)->Void)?
    
    //MARK:- View LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return queryViewModel.totalRows()
        return dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table view Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        menuItemSelectedHandler?(dataSource[indexPath.row])
        
    }
    
}
