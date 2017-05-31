//
//  ViewController.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/1/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit
import Alamofire


class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var items = [Item]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                    
                     let genre_ids = item["genre_ids"] as! [Int]
                         for genre_id in genre_ids {
                          print("genre_id : \(genre_id)")
                         
                       }
                       print("=======================")
                    
//                 let item = Item(imageUrl: item["poster_path"]! as! String, imageTitle:  item["title"]! as! String)
//                    
//                      items.append(item)
                }
                
                print(results.count)
            }
        }
        
//        let item1 = Item(imageUrl: "", imageTitle: "Yasser 1")
//        let item2 = Item(imageUrl: "", imageTitle: "Yasser 2")
//        let item3 = Item(imageUrl: "", imageTitle: "Yasser 3")
//        let item4 = Item(imageUrl: "", imageTitle: "Yasser 4")
//        items.append(item1)
//        items.append(item2)
//        items.append(item3)
//        items.append(item4)
        
        
        
        
        for index in 6...100 {
           // items.append(Item(imageUrl: "", imageTitle: "Yasser \(index)"))
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! MainTableViewCell
        cell.updateUI(item: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: items[indexPath.row])
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if let destination = segue.destination as? DetailsViewController {
//            if let item = sender as? Item{
//                destination.selectedItem = item
//            }
//        }
    }
    

    
    func fetchAllPopular() {
        
        Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=eaec4bfed9794e1861e198547d9d9073").responseJSON { response in
            print(response.request!)  // original URL request
            print("=============\n")
            print(response.response!) // HTTP URL response
                     print("=============\n")
            print(response.data!)     // server data
                     print("=============\n")
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
//            }
            
            print("Success: \(response.result.isSuccess)")
            
            if response.result.isSuccess {
                    print("Response String: \(response.result.value)")
                
                
            } else {
                  print("Failed JSON")
            }
            
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

