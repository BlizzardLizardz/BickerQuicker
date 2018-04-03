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
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var numArgsLost: UILabel!
    @IBOutlet weak var numArgsWon: UILabel!
    @IBOutlet weak var profileBickerTableView: UITableView!
    
    var bickers: [Bicker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setGradientBackground(colors: [.boyBlue(), .girlPink()])
        UserApi.sharedInstance.getUserBickers { (bickers) in
            if let bickers = bickers {
                self.bickers = bickers
            } else {
                print("coudn't get bickers")
            }
        }
        
        var gender: Gender?
        var username: String?
        if let userInfo = UserApi.sharedInstance.getUserInfo() {
            gender = userInfo.gender
            username = userInfo.username
        }
        nameLabel.text = username
        genderLabel.text = gender?.rawValue
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
