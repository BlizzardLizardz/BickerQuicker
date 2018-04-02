//
//  PostDetailViewController.swift
//  BickerQuicker
//
//  Created by Jonathan Grider on 3/21/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UIViewController {
    
    var bicker: Bicker!
    var voted = false
    let hapticFeedback = UIImpactFeedbackGenerator()
    
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
    @IBOutlet weak var leftFemaleVotes: UILabel!
    @IBOutlet weak var leftMaleVotes: UILabel!
    @IBOutlet weak var rightMaleVotes: UILabel!
    @IBOutlet weak var rightFemaleVotes: UILabel!
    @IBOutlet weak var bottomSideLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var topSideLabel: UILabel!
    @IBOutlet weak var totalsLabel: UILabel!
    @IBOutlet weak var leftMaleButton: UIButton!
    @IBOutlet weak var leftFemaleButton: UIButton!
    @IBOutlet weak var rightMaleButton: UIButton!
    @IBOutlet weak var rightFemaleButton: UIButton!
    
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
        
        let vote = bicker.getVote()
        if vote == nil {
            changeAlphas(newAlpha: 0, duration: 0)
        } else {
            changeAlphas(newAlpha: 1, duration: 0.5)
        }
        
        setFields()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didVoteLeft(_ sender: UIButton) {
        hapticFeedback.impactOccurred()
        
        bicker.vote(side: .left) { (success, error) in
            if let error = error {
                print("Something went wrong while voting: ")
                print(error.localizedDescription)
            } else {
                print("Voting for LEFT side successful!")
                self.updateButtons(side: .left)
                self.setVotes(bicker: self.bicker)
                self.changeAlphas(newAlpha: 1, duration: 0.5)
            }
        }
        
    }
    
    @IBAction func didVoteRight(_ sender: UIButton) {
        hapticFeedback.impactOccurred()
        
        bicker.vote(side: .right) { (success, error) in
            if let error = error {
                print("Something went wrong while voting: ")
                print(error.localizedDescription)
            } else {
                print("Voting for RIGHT side successful!")
                self.updateButtons(side: .right)
                self.setVotes(bicker: self.bicker)
                self.changeAlphas(newAlpha: 1, duration: 0.5)
            }
        }
    }
    
    func updateButtons(side: Side) {
        // See if the user has voted for this bicker
        if side == .left {
            // Update buttons
            leftVoteButton.isUserInteractionEnabled = false
            rightVoteButton.isUserInteractionEnabled = true
            
            print("LEFT SIDE")
            
            UIView.animate(withDuration: 0.25, animations: {
                self.leftVoteButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) //#colorLiteral(red: 0.9639316307, green: 0.9639316307, blue: 0.9639316307, alpha: 1)
            //    self.leftVoteButton.titleLabel?.textColor = .boyBlue()
                self.rightVoteButton.backgroundColor = .girlPink()
             //   self.rightVoteButton.titleLabel?.textColor = .white
            })

            
        } else {
            // Update buttons
            leftVoteButton.isUserInteractionEnabled = true
            rightVoteButton.isUserInteractionEnabled = false
            
            print("RIGHT SIDE")
            
            UIView.animate(withDuration: 0.25, animations: {
                self.rightVoteButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) //#colorLiteral(red: 0.9639316307, green: 0.9639316307, blue: 0.9639316307, alpha: 1)
                //self.rightVoteButton.titleLabel?.textColor = .girlPink()
                self.leftVoteButton.backgroundColor = .lightBoyBlue()
            //    self.leftVoteButton.titleLabel?.textColor = .white
            })
            
        }
        
    }
    
    func setFields() {
        if let bicker = bicker {
            // Box text
            leftTextLabel.text = bicker.leftText
            rightTextLabel.text = bicker.rightText
            
            setVotes(bicker: bicker)
            
            if let side = bicker.getVote() {
                updateButtons(side: side)
                voted = true
            }
            
        }
    }
    
    func setVotes(bicker: Bicker) {
        // Left side votes
        leftMaleVotes.text = String(bicker.leftMaleVote)
        leftFemaleVotes.text = String(bicker.leftFemVote)
        
        // Right side votes
        rightMaleVotes.text = String(bicker.rightMaleVote)
        rightFemaleVotes.text = String(bicker.rightFemVote)
        
        // Total votes
        leftTotalVotes.text = String(bicker.leftMaleVote + bicker.leftFemVote)
        rightTotalVotes.text = String(bicker.rightMaleVote + bicker.rightFemVote)
    }
    
    func changeAlphas(newAlpha: CGFloat, duration: Double) {
        
        UIView.animate(withDuration: duration) {
            self.leftBoxBackground.alpha = newAlpha
            self.rightBoxBackground.alpha = newAlpha
            self.leftMaleVotes.alpha = newAlpha
            self.leftFemaleVotes.alpha = newAlpha
            self.rightMaleVotes.alpha = newAlpha
            self.rightFemaleVotes.alpha = newAlpha
            self.totalsLabel.alpha = newAlpha
            self.leftMaleButton.alpha = newAlpha
            self.leftFemaleButton.alpha = newAlpha
            self.rightMaleButton.alpha = newAlpha
            self.rightFemaleButton.alpha = newAlpha
        }
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
