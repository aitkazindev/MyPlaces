//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/28.
//

import UIKit

class MainTableViewController: UITableViewController {

    let restaurantNames = ["Burger King", "Mums touch", "McDonalds"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.imageOfplace.image = UIImage(named: restaurantNames[indexPath.row])
        cell.imageOfplace.layer.cornerRadius = cell.imageOfplace.frame.height / 2
        cell.imageOfplace.clipsToBounds = true
        return cell
    }
    
    // MARK:  Table View delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
