//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/28.
//

import UIKit

class MainTableViewController: UITableViewController {

    
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfplace.image = UIImage(named: places[indexPath.row].image)
        
        cell.imageOfplace.layer.cornerRadius = cell.imageOfplace.frame.height / 2
        cell.imageOfplace.clipsToBounds = true
        
        return cell
    }
}
