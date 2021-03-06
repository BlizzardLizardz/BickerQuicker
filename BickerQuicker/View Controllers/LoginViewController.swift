//
//  LoginViewController.swift
//  BickerQuicker
//
//  Created by Brendan Raftery on 2/26/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var bickerLabel: UILabel!
    @IBOutlet weak var quickerLabel: UILabel!
    
    let invalidAlert = UIAlertController(title: "Invalid ", message: "The username or password was invalid. Please try again.", preferredStyle: .alert)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.borderColor = UIColor.bickerPurple().cgColor
        signUpButton.layer.backgroundColor = UIColor.white.cgColor
        signUpButton.layer.borderWidth = 1.0
        signUpButton.setTitleColor(UIColor.bickerPurple(), for: [])
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.masksToBounds = true
        
        logInButton.layer.cornerRadius = 10.0
        logInButton.layer.masksToBounds = true
        
        bickerLabel.textColor = UIColor.girlPink()
        quickerLabel.textColor = UIColor.boyBlue()
        
        setupAlertControllers()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if !validateFields() {
            
            // Fields were invalid
            self.present(invalidAlert, animated: true)
            return
        }
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "Username or password is invalid. Please try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func loginViewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func setupAlertControllers() {
        // Set up alert for pre-existing username
        let OKAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            // Do nothing
        }
        
        self.invalidAlert.addAction(OKAction)
    }
    
    func validateFields() -> Bool {
        return usernameField.hasText && passwordField.hasText
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
