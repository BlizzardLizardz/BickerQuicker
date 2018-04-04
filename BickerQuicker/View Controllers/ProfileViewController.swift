//
//  ProfileViewController.swift
//  BickerQuicker
//
//  Created by Jonathan Grider on 3/19/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var profileBickerTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var bickers: [Bicker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBar.setGradientBackground(colors: [.boyBlue(), .girlPink()])
        tableView.dataSource = self
        var gender: Gender?
        var username: String?
        if let userInfo = UserApi.sharedInstance.getUserInfo() {
            gender = userInfo.gender
            username = userInfo.username
        }
        nameLabel.text = username
        genderLabel.text = gender?.rawValue
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        UserApi.sharedInstance.getUserBickers { (bickers) in
            if let bickers = bickers {
                self.bickers = bickers
                self.tableView.reloadData()
            } else {
                print("coudn't get bickers")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bickers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenderedTableViewCell") as! GenderedBickerCell
        cell.bicker = bickers[indexPath.row]
        cell.selectionStyle = .none
        return cell
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
            }
        }
    }

}
