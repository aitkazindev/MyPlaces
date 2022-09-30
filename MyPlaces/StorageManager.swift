//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/30.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place){
        try! realm.write{
            realm.add(place)
        }
    }
}


