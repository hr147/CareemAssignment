//
//  AppRootCoordinator.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/13/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit


protocol RootCoordinator: class {
    
    
}


class AppRootCoordinator: RootCoordinator {
    
    var rootViewController: UIViewController
    
    init(with rootViewController: UIViewController) {
        
        self.rootViewController = rootViewController
        
    }

}
