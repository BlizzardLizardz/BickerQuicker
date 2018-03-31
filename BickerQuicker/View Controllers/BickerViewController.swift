//
//  BickerViewController.swift
//  BickerQuicker
//
//  Created by Harjas Monga on 3/14/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class BickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReloadableDelegate {
    
    @IBOutlet weak var segmentationController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let logoutAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to log out?", preferredStyle: .alert)
    var skip: Int = 0
    var hapticFeedback = UIImpactFeedbackGenerator()
    var refreshControl: UIRefreshControl!
    var bickers: [Bicker] = [] {
        didSet {
            if oldValue != bickers {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add refresh controller
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshBickers), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
        getBickers(startFromBegining: true)
        
        setupAlerts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        present(logoutAlert, animated: true) {
            // If they tap Logout, let the API handler log them out.
        }
    }
    
    func setupAlerts() {
        
        // Set up logout alert controller
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            self.logOut()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Do nothing; dismisses the view
        }
        
        // Add actions
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancelAction)
    }
    
    func logOut() {
        
        print("logout function called")
        PFUser.logOutInBackground { (error: Error? ) in
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "UnauthorizedView")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenderedTableViewCell", for: indexPath) as! GenderedBickerCell
        cell.bicker = bickers[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bickers.count
    }
    
    @objc func refreshBickers() {
        skip = 0
        hapticFeedback.impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            // Stop the refresh controller
            self.refreshControl.endRefreshing()
        }
        
        getBickers(startFromBegining: true)
        
    }
    
    func getBickers(startFromBegining: Bool) {
        var order = Order.createdAt
        if segmentationController.selectedSegmentIndex == 1 {
            order = Order.totalVotes
        }
        
        Bicker.getBickers(skip: skip, limit: 20, order: order) { (bickers) in
            if let newBickers = bickers {
                self.skip += newBickers.count
                if startFromBegining {
                    self.bickers = newBickers
                    print("setting bickers")
                } else {
                    self.bickers.append(contentsOf: newBickers)
                    print("appending bickers")
                }
            } else {
                print("WE DIDNT GET BICKERS🤬")
            }
        }
    }
    
    @IBAction func segmentationValueChanged(_ sender: Any) {
        skip = 0
        getBickers(startFromBegining: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == bickers.count - 1 {
            getBickers(startFromBegining: false)
        }
    }
    
    func reloadData() {
        skip = 0
        getBickers(startFromBegining: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "detailViewSegue" {
                print("We're heading to the detail view!")
                let detailView = segue.destination as! PostDetailViewController
                let cell = sender as! UITableViewCell
                if let indexPath = tableView.indexPath(for: cell) {
                    detailView.bicker = bickers[indexPath.row]
                    print("Left Text: " + bickers[indexPath.row].leftText)
                } else {
                    print("NO BICKERS HERE! HUE HUE HUE")
                }
            } else if identifier == "createBicker" {
                let createBickerController = segue.destination as! PostViewController
                createBickerController.delegate = self
            }
        }
    }
}
