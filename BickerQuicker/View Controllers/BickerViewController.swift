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
    
    var bickers: [Bicker]! {
        didSet {
            tableView.reloadData()
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
        
        getBickers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Later update to add cell to table via delegate
        getBickers()
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
        if bickers == nil {
            return 0
        }
        
        return bickers.count
    }
    
    @objc func refreshBickers() {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            // Stop the refresh controller
            self.refreshControl.endRefreshing()
        }
        
        getBickers()
        
    }
    
    func getBickers() {
        Bicker.getBickers(limit: 20) { (bickers) in
            if let bickers = bickers {
                self.bickers = bickers
            } else {
                print("WE DIDNT GET BICKERS🤬")
                // todo: Warning message or something
            }
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
