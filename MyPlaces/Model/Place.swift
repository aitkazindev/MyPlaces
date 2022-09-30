//
//  Place.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/28.
//

import UIKit

struct Place{
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    static let restaurantNames =  [
        "Bonsai", "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub", "Sherlock Holmes", "Speak Easy", "X.O"
    ]
    static func getPlaces() -> [Place] {
        var places: [Place] = []
        
        for place in restaurantNames {
            places.append(Place(name: place,location: "Seoul",type:"Restaurant", image: nil, restaurantImage: place))
        }
        
        return places
    }
}
