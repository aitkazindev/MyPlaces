//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/28.
//

import UIKit
import RealmSwift

class MainTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var places: Results<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.isEmpty ? 0 : places.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfplace.image = UIImage(data: place.imageData!)
        cell.imageOfplace.layer.cornerRadius = cell.imageOfplace.frame.height / 2
        cell.imageOfplace.clipsToBounds = true
        
        return cell
    }
    
    // MARK:  Table view delegate
    
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let place = places[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_,_) in
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else {return}
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceTableViewController
            newPlaceVC.currentPlace = place 
        }
    }
}
