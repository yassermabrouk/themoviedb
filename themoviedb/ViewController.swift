//
//  ViewController.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/1/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

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
                }
                
                print(results.count)
            }
        }
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

