//
//  SecondViewController.swift
//  REFrostedViewControllerSwiftExample
//
//  Created by Benny Singer on 5/20/17.
//  Copyright © 2017 Benny Singer. All rights reserved.
//

import UIKit
import HandySwift
import Alamofire
class PopularViewController: UIViewController {
    var items = [Movie]()
    let reuseIdentifier = "PopularViewControllerReuseIdentifier"
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    let itemsPerRow: CGFloat = 2
    var refresher:UIRefreshControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.refresher.beginRefreshing()
    }
    
    
    func refreshControl() {
        // Do your job, when done:
        self.items = [Movie]()
        requestPopularMovies()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "Toggle",
            style: .done,
            target: self,
            action: #selector(PopularViewController.showMenu(_:))
        )
        
        self.navigationItem.leftBarButtonItem = leftButtonItem
        
        // Do any additional setup after loading the view.
        
        self.requestPopularMovies();
        
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshControl), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
    }
    func requestPopularMovies(){
        // Using Alamofire with Router
        Alamofire.request(Router.getPopular()).responseJSON { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                 print(response.result.error!)
                return
            }
            
            
            if let responseJSON = response.result.value as? [String: Any] {
                
                guard let moviesResults = MovieResults(json: responseJSON) else  {
                    return
                }
                self.items = moviesResults.movies
                
                delay(by: 1.5) {
                    self.collectionView?.reloadData()
                    self.refresher.endRefreshing()
                }
                
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(_ sender: Any) {
        // Dismiss keyboard (optional)
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        
        // Present the view controller
        self.frostedViewController.presentMenuViewController()
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PopularViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    //1
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
     func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    //3
     func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! PopularCollectionViewCell
        cell.updateUI(item: items[indexPath.row])
    
        // Configure the cell
        return cell
    }
}
extension PopularViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


