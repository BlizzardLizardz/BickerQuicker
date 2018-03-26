//
//  BickerViewController.swift
//  BickerQuicker
//
//  Created by Harjas Monga on 3/14/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class BickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var skip: Int = 0
    
    var bickers: [Bicker] = [] {
        didSet {
            if oldValue != bickers {
                tableView.reloadData()
            }
        }
    }
    var refreshControl: UIRefreshControl!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Later update to add cell to table via delegate
     //   getBickers(startFromBegining: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        logOut()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bickers.count
    }
    
    @objc func refreshBickers() {
        
        skip = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            // Stop the refresh controller
            self.refreshControl.endRefreshing()
        }
        
        getBickers(startFromBegining: true)
        
    }
    
    func getBickers(startFromBegining: Bool) {
        Bicker.getBickers(skip: skip, limit: 20) { (bickers) in
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
                // todo: Warning message or something
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == bickers.count - 1 {
            getBickers(startFromBegining: false)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "detailViewSegue" {
                let detailView = segue.destination as! PostDetailViewController
                let cell = sender as! UITableViewCell
                if let indexPath = tableView.indexPath(for: cell) {
                    detailView.bicker = bickers[indexPath.row]
                }
            }
        }
    }
}
