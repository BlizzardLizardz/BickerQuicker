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
    @NSManaged var leftVoteUsers: [PFUser]
    @NSManaged var rightVoteUsers: [PFUser]
    @NSManaged var isAnonymous: Bool
    @NSManaged var totalVotes: Int
    
    class func parseClassName() -> String {
        return "Bicker"
    }
    
    class func postBicker(leftText: String, rightText: String, isGendered: Bool, isAnonymous: Bool, withCompletion completion: PFBooleanResultBlock?) {
        let bicker = Bicker()
        bicker.createdBy = PFUser.current()!
        bicker.leftText = leftText
        bicker.rightText = rightText
        bicker.isGendered = isGendered
        bicker.leftFemVote = 0
        bicker.leftMaleVote = 0
        bicker.rightFemVote = 0
        bicker.rightMaleVote = 0
        bicker.totalVotes = 0
        bicker.leftVoteUsers = []
        bicker.rightVoteUsers = []
        bicker.isAnonymous = isAnonymous
        bicker.saveInBackground(block: completion)
    }
    
    class func getBickers(skip: Int, limit: Int, order: Order, completion: @escaping ([Bicker]?) -> ()) {
        let query = Bicker.query()!
        query.order(byDescending: order.rawValue)
        query.includeKey("author")
        query.limit = limit
        query.skip = skip
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
    
    func vote(side: Side, completion: @escaping (Bool, Error?) -> ()) {
        guard let user = PFUser.current() else {
            print("Error! Coudn't get current user!")
            completion(false, nil)
            return
        }
        
        if !canVote(side: side) {
            completion(false, nil)
            return
        }
        
        guard let genderString = user["gender"] as? String else {
            print("Error! Coudn't get users's gender")
            completion(false, nil)
            return
        }
        
        guard let gender = Gender(rawValue: genderString) else {
            print("user has a nonvalid gender")
            completion(false, nil)
            return
        }
        
        var newVote = true
        if let currentSide = getVote() {
            newVote = false
            switch currentSide {
            case .right:
                remove(user, forKey: "rightVoteUsers")
                if gender == .Girl {
                    incrementKey("rightFemVote", byAmount: -1)
                } else {
                    incrementKey("rightMaleVote", byAmount: -1)
                }
            case .left:
                remove(user, forKey: "leftVoteUsers")
                if gender == .Girl {
                    incrementKey("leftFemVote", byAmount: -1)
                } else {
                    incrementKey("leftMaleVote", byAmount: -1)
                }
            }
        }
        
        switch gender {
        case .Girl:
            incrementKey("\(side.rawValue)FemVote")
        case .Guy:
            incrementKey("\(side.rawValue)MaleVote")
        }
        
        if newVote {
            incrementKey("totalVotes")
        }
        
        add(user, forKey: "\(side.rawValue)VoteUsers")
        saveInBackground { (success, error) in
            if let error = error {
                completion(false, error)
            } else {
                print("My left side: " + self.leftText)
                completion(true, nil)
            }
        }
    }
    
    func getVote() -> Side? {
        guard let currentUser = PFUser.current() else {
            print("Coudn't get current user")
            return nil
        }
        
        for leftVoteUser in leftVoteUsers {
            if leftVoteUser.objectId == currentUser.objectId {
                return Side.left
            }
        }
        
        for rightVoteUser in rightVoteUsers {
            if rightVoteUser.objectId == currentUser.objectId  {
                return Side.right
            }
        }
        
        return nil
    }
    
    func canVote(side: Side) -> Bool {
        guard let sideVotedFor = getVote() else {
            return true
        }
        
        return sideVotedFor != side
    }
}

