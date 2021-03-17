//
//  StorageManager.swift
//  Notes
//
//  Created by Vlad on 12.03.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObjct(_ note: Note){
        try! realm.write{
            realm.add(note)
        }
    }
    
    static func deleteObject(_ note: Note) {
        try! realm.write{
            realm.delete(note)
        }
    }
}
