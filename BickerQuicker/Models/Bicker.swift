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
    @NSManaged var isGendered: Bool
    
    class func parseClassName() -> String {
        return "Bicker"
    }
  
    class func postBicker(leftText: String, rightText: String, isGendered: Bool, withCompletion completion: PFBooleanResultBlock?) {
        let bicker = Bicker()
        bicker.createdBy = PFUser.current()!
        bicker.leftText = leftText
        bicker.rightText = rightText
        bicker.isGendered = isGendered
        bicker.leftFemVote = 0
        bicker.leftMaleVote = 0
        bicker.rightFemVote = 0
        bicker.rightMaleVote = 0
        bicker.saveInBackground(block: completion)
    }
  
    class func getBickers(limit: Int, completion: @escaping ([Bicker]?) -> ()) {
        let query = Bicker.query()!
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = limit
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                completion(nil)
                print(error.localizedDescription)
            } else if let posts = posts {
                let bickers = posts as? [Bicker]
                completion(bickers)
            }
        }
    }
    func voteLeft(completion: PFBooleanResultBlock?) {
        guard let user = PFUser.current() else {
            print("Error! Coudn't get current user!")
            return;
        }
        guard let gender = user["gender"] as? String else {
            print("Error! Coudn't get users's gender")
            return;
        }
        switch gender {
            case "Guy":
                incrementKey("leftMaleVote")
            case "Girl":
                incrementKey("leftFemalVote")
            default:
                print("Other gender. don't know how to handle yet")
        }
        saveInBackground(block: completion)
    }
    func voteRight(completion: PFBooleanResultBlock?) {
        guard let user = PFUser.current() else {
            print("Error! Coudn't get current user!")
            return;
        }
        guard let gender = user["gender"] as? String else {
            print("Error! Coudn't get users's gender")
            return;
        }
        switch gender {
            case "Guy":
                incrementKey("rightMaleVote")
            case "Girl":
                incrementKey("rightFemaleVote")
            default:
                print("Other gender. don't know how to handle yet")
        }
        saveInBackground(block: completion)
    }
}
