//
//  MainTableViewController.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/13/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit
import HandySwift
import Alamofire

class MainTableViewController: UITableViewController {
    
    var items = [Movie]()
    var dateFormatter = DateFormatter()
    

    @IBAction func showMenu(_ sender: Any) {
        // Dismiss keyboard (optional)
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        
        // Present the view controller
        self.frostedViewController.presentMenuViewController()
    }
    
    
    func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        self.items = [Movie]()
        animateTable()
        requestPopularMovies()

      
    }
    
    func requestPopularMovies(){
        // Using Alamofire with Router
        Alamofire.request(Router.getPopular()).responseJSON { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                // print(response.result.error!)
                return
            }
            
            
            if let responseJSON = response.result.value as? [String: Any] {
                
                guard let moviesResults = MovieResults(json: responseJSON) else  {
                    
                    // print("Yasser Error initializing object")
                    return
                }
                self.items = moviesResults.movies
                
                delay(by: 1.5) {
                    // delayed code, by default run in main thread
                     self.displayLastUpdate()
                     self.animateTable()
                }
        
                //                guard let firstItem = moviesResults.movies.first else {
                //                    // print("Yasser  No such item")
                //                    return
                //                }
                //                // print( "\(firstItem)")
                //
                //
                //                // Parsing JSON Object
                //                let page = responseJSON["page"] as? Int
                //                // print("page : \(page!)")
                //                let results = responseJSON["results"] as! [[String: Any]]
                //
                //                for item in results {
                //                    // print("poster_path : \(item["poster_path"]!)")
                //
                //                    let poster_path =    item["poster_path"]!
                //
                //                    let poster_url = "https://image.tmdb.org/t/p/original/" + (poster_path as! String)
                //
                //                    let title = item["title"]!
                //
                //                    let description = item["overview"]!
                //
                //
                ////                    let movie = Item(imageUrl: poster_url, imageTitle: title as! String, description: description as! String )
                //////
                ////                    var movie: Movie
                ////                    movie.poster_path = poster_path  as? String
                ////                    movie.original_title = title as? String
                ////                    movie.overview = description as? String
                //
                //
                //
                ////                    let genre_ids = item["genre_ids"] as! [Int]
                ////                    for genre_id in genre_ids {
                ////                        // print("genre_id : \(genre_id)")
                ////
                ////                    }
                ////
                //                    self.items = moviesResults.movies
                
                // print("=======================")
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dateFormatter.dateStyle = DateFormatter.Style.short
        self.dateFormatter.timeStyle = DateFormatter.Style.long
       
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        
                if #available(iOS 10.0, *) {
                    tableView.refreshControl = refreshControl
                } else {
                    tableView.backgroundView = refreshControl
                }
        
        requestPopularMovies()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
      refreshControl?.beginRefreshing()
    }
    
    func animateTable() {
        
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as! MainTableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            
            let cell: UITableViewCell = a as! MainTableViewCell
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                
            }, completion: nil)
            
            index += 1
        }
    }
    
    func displayLastUpdate(){
        let now = Date()
        
        let updateString = "Last Updated at " + self.dateFormatter.string(from: now)
        
        refreshControl?.attributedTitle = NSAttributedString(string: updateString)
        
        refreshControl?.endRefreshing()
    
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // print("numberOfSections")
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // print("numberOfRowsInSection")
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.updateUI(item: items[indexPath.row])
        // print("cellForRowAt")
        return cell
        
    }
    
    
    
}
