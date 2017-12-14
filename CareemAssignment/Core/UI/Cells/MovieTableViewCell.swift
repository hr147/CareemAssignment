//
//  MovieTableViewCell.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/14/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    fileprivate var viewModel:MovieTableViewCellViewModeling!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    static let identifier:String = {
        
        return "MovieTableViewCell"
    
    }()
}


extension MovieTableViewCell {
    
    func configure(with viewModel:MovieTableViewCellViewModeling) {
        
        self.viewModel = viewModel
        
        posterImageView?.lazyLoadImage(withUrlString: viewModel.posterPath, placeholderImage: nil)
        titleLabel.text = viewModel.name
        releaseLabel.text = viewModel.release
        overviewLabel.text = viewModel.overrivew
        
    }
    
}
