//
//  MainTableViewCell.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/13/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit
import Kingfisher


class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    func updateUI(item : Item){
        itemLabel.text = item.itemTitle
        descriptionLabel.text = item.itemDescription
        
        self.itemImageView.kf.indicatorType = .activity
        let url = URL(string: item.itemUrl)
        self.itemImageView.kf.setImage(with: url)
        (self.itemImageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        itemImageView.contentMode = .scaleAspectFit
        
        
        // Basic download
//        if let checkedUrl = URL(string: item.itemUrl) {
//            itemImageView.contentMode = .scaleAspectFit
//            downloadImage(url: checkedUrl)
//        }
    
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.itemImageView.image = UIImage(data: data)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
