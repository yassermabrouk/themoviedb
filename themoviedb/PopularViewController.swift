//
//  SecondViewController.swift
//  REFrostedViewControllerSwiftExample
//
//  Created by Benny Singer on 5/20/17.
//  Copyright © 2017 Benny Singer. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {

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
