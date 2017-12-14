//
//  UIImageView+Extension.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/15/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
import Kingfisher

protocol ImageLazyLoading {
    
    func lazyLoadImage(withUrlString urlString:String?,placeholderImage placeholder:UIImage?)
    
}

extension UIImageView:ImageLazyLoading {

    func lazyLoadImage(withUrlString urlString: String?, placeholderImage placeholder: UIImage?) {
        
        image = placeholder
        
        guard
            let _urlString = urlString,
            let imageURL = URL(string:_urlString)
            else { return }
        
        kf.setImage(with: imageURL, placeholder: placeholder)
        
    }

}
