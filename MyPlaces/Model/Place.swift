//
//  Place.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/28.
//
import UIKit
import RealmSwift
class Place: Object{
    
    @Persisted var name: String = ""
    @Persisted var location: String?
    @Persisted var type: String?
    @Persisted var imageData: Data?
    @Persisted var date = Date()
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
