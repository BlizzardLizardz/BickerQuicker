//
//  SignUpViewController.swift
//  BickerQuicker
//
//  Created by Brendan Raftery on 3/1/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatField: UITextField!
    @IBOutlet weak var genderSelect: UISegmentedControl!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.layer.borderColor = UIColor.bickerPurple().cgColor
        cancelButton.layer.backgroundColor = UIColor.white.cgColor
        cancelButton.layer.borderWidth = 1.0
        cancelButton.setTitleColor(UIColor.bickerPurple(), for:[])
        cancelButton.layer.cornerRadius = 10.0
        cancelButton.layer.masksToBounds = true

        signupButton.layer.cornerRadius = 10.0
        signupButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signupButtonPressed(_ sender: Any) {
        let newUser = PFUser()
        let signupErrorAlert = UIAlertController(title: "Error Signup", message: "Password Mistmatch", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        signupErrorAlert.addAction(okayAction)
        if passwordField.text != repeatField.text {
            self.present(signupErrorAlert, animated: true, completion: nil)
            return
        }
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser["gender"] = genderSelect.titleForSegment(at: genderSelect.selectedSegmentIndex)
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                signupErrorAlert.message = "There was issue registering your account. Please try again."
                self.present(signupErrorAlert, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("registration sucessful!")
            }
        }
    }
    @IBAction func signUpViewTapped(_ sender: Any) {
        self.view.endEditing(true)
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
