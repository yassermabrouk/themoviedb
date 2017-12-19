//
//  PopularCollectionViewCell.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 9/7/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    func updateUI(item : Movie){
        self.imageView.kf.indicatorType = .activity
        
        let url = URL(string: item.poster_full_path())
        self.imageView.kf.setImage(with: url)
        (self.imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        movieName.text = item.original_title
    }
}
