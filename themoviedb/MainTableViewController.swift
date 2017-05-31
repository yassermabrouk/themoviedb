//
//  MainTableViewController.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/13/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit

import Alamofire
class MainTableViewController: UITableViewController {
    
    
    var items = [Item]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Using Alamofire with Router
        Alamofire.request(Router.getPopular()).responseJSON { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print(response.result.error!)
                return
            }
            
            // print("Response String: \(response.result.value)")
            
            if let responseJSON = response.result.value as? [String: Any] {
                
                // Parsing JSON Object
                let page = responseJSON["page"] as? Int
                print("page : \(page!)")
                let results = responseJSON["results"] as! [[String: Any]]
                
                for item in results {
                    print("poster_path : \(item["poster_path"]!)")
                    
                    let poster_path =    item["poster_path"]!
                    
                    let poster_url = "https://image.tmdb.org/t/p/original/" + (poster_path as! String)
                    
                    let title = item["title"]!
                    
                    let description = item["overview"]!
                    
                    
                     let movie = Item(imageUrl: poster_url, imageTitle: title as! String, description: description as! String )
                    
                    let genre_ids = item["genre_ids"] as! [Int]
                    for genre_id in genre_ids {
                        print("genre_id : \(genre_id)")
                        
                    }
                    
                    self.items.append(movie)
                    
                    print("=======================")
                }
                 self.tableView.reloadData()
                print(results.count)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
               print("numberOfSections")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
               print("numberOfRowsInSection")
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.updateUI(item: items[indexPath.row])
                print("cellForRowAt")
        return cell

    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
