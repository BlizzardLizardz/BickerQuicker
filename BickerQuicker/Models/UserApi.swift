//
//  UserApi.swift
//  BickerQuicker
//
//  Created by Harjas Monga on 3/26/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import Foundation
import Parse

class UserApi {
    
    static var sharedInstance = UserApi()
    
    func getUserBickers(completion: @escaping ([Bicker]?) -> ()) {
        guard let currentUser = PFUser.current() else {
            completion(nil)
            print("Error! Coudn't get current user!")
            return;
        }
        
        let query = Bicker.query()!
        query.whereKey("createdBy", equalTo: currentUser)
        query.findObjectsInBackground { (bickers, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let bickers = bickers {
                completion(bickers as? [Bicker])
            }
        }
    }
    
    func getUserInfo() -> (username: String?, gender: Gender)? {
        guard let user = PFUser.current() else {
            return nil
        }
        guard let genderString = user["gender"] as? String else {
            return nil
        }
        guard let gender = Gender(rawValue: genderString) else {
            return nil
        }
        return (user.username, gender)
    }
}
