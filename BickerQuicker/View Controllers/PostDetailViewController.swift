//
//  PostDetailViewController.swift
//  BickerQuicker
//
//  Created by Jonathan Grider on 3/21/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var bicker: Bicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bicker.voteLeft { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if success {
                print("success")
            } else {
                print("faliure")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
