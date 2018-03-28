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
    
    @IBOutlet weak var leftVoteButton: UIButton!
    @IBOutlet weak var rightVoteButton: UIButton!
    @IBOutlet weak var rightTitleBackground: UIView!
    @IBOutlet weak var rightBackground: UIView!
    @IBOutlet weak var leftBackground: UIView!
    @IBOutlet weak var rightBoxBackground: UIView!
    @IBOutlet weak var leftBoxBackground: UIView!
    @IBOutlet weak var leftTitleBackground: UIView!
    @IBOutlet weak var rightTotalVotes: UILabel!
    @IBOutlet weak var leftTotalVotes: UILabel!
    @IBOutlet weak var rightFemaleVotes: UIImageView!
    @IBOutlet weak var rightMaleVotes: UIImageView!
    @IBOutlet weak var leftFemaleVotes: UILabel!
    @IBOutlet weak var leftMaleVotes: UILabel!
    @IBOutlet weak var bottomSideLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var topSideLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTitleBackground.clipsToBounds = true;
        leftTitleBackground.layer.cornerRadius = 7

        rightTitleBackground.clipsToBounds = true;
        rightTitleBackground.layer.cornerRadius = 7
        
        leftBackground.clipsToBounds = true;
        leftBackground.layer.cornerRadius = 7
        
        rightBackground.clipsToBounds = true;
        rightBackground.layer.cornerRadius = 7
        
        leftBoxBackground.clipsToBounds = true;
        leftBoxBackground.layer.cornerRadius = 7
        leftBoxBackground.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        rightBoxBackground.clipsToBounds = true;
        rightBoxBackground.layer.cornerRadius = 7
        rightBoxBackground.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        
        leftVoteButton.clipsToBounds = true
        leftVoteButton.layer.cornerRadius = 7
        
        rightVoteButton.clipsToBounds = true
        rightVoteButton.layer.cornerRadius = 7
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
