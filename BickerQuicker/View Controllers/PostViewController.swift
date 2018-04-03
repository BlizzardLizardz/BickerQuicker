//
//  PostViewController.swift
//  BickerQuicker
//
//  Created by Jonathan Grider on 3/19/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    @IBOutlet weak var leftSideTextView: UITextView!
    @IBOutlet weak var rightSideTextView: UITextView!
    
    var delegate: ReloadableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors = [UIColor]()
        navigationController?.navigationBar.setGradientBackground(colors: [.boyBlue(), .girlPink()])
    }
    
    @IBAction func postButtonPressed(_ sender: UIBarButtonItem) {
        Bicker.postBicker(leftText: leftSideTextView.text, rightText: rightSideTextView.text, isGendered: false,       isAnonymous: false) { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if success {
                self.delegate?.reloadData()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}
