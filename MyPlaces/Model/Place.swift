//
//  Place.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/28.
//

import Foundation

struct Place{
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    static func getPlaces() -> [Place] {
        let places = [
            Place(name: "Burger King", location: "Seoul", type: "Fast Food", image: "Burger King"),
            Place(name: "Mums touch", location: "Seoul", type: "Fast Food", image: "Mums touch"),
            Place(name: "McDonalds", location: "Seoul", type: "Fast Food", image: "McDonalds")
        ]
        
        return places
    }
}
