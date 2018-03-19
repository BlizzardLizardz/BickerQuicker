//
//  Bicker.swift
//  BickerQuicker
//
//  Created by Harjas Monga on 3/19/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import Foundation
import Parse

class Bicker : PFObject, PFSubclassing {
   
    @NSManaged var createdBy: PFUser
    @NSManaged var leftText: String
    @NSManaged var rightText: String
    @NSManaged var leftFemVote: Int
    @NSManaged var leftMaleVote: Int
    @NSManaged var rightFemVote: Int
    @NSManaged var rightMaleVote: Int
    
    class func parseClassName() -> String {
        return "Bicker"
    }
    class func postBicker(leftText: String, rightText: String, withCompletion completion: PFBooleanResultBlock?) {
        let bicker = Bicker()
        bicker.createdBy = PFUser.current()!
        bicker.leftText = leftText
        bicker.rightText = rightText
        bicker.leftFemVote = 0
        bicker.leftMaleVote = 0
        bicker.rightFemVote = 0
        bicker.rightMaleVote = 0
        bicker.saveInBackground(block: completion)
    }
}
