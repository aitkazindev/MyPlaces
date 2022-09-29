//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/29.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    // MARK:  View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK:  Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        }else{
            view.endEditing(true)
        }
    }
}

// MARK:  Text field delefate

extension NewPlaceTableViewController: UITextFieldDelegate{
    
    // Hiding keyboard after pressing done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
