//
//  ProfileViewController.swift
//  BickerQuicker
//
//  Created by Jonathan Grider on 3/19/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var relationshipStatusLabel: UILabel!
    
    @IBOutlet weak var numArgsLost: UILabel!
    
    @IBOutlet weak var numArgsWon: UILabel!
    
    @IBOutlet weak var profileBickerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserApi.sharedInstance.getUserBickers { (bickers) in
            if let bickers = bickers {
                print(bickers)
            } else {
                print("coudn't get bickers")
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
