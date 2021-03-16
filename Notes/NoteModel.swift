//
//  NoteModel.swift
//  Notes
//
//  Created by Vlad on 12.03.2021.
//

import RealmSwift

class Note: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var tittle: String = ""
    @objc dynamic var noteText: String?
    @objc dynamic var image: Data?
   // @objc dynamic let createDate: NSDate
    //@objc dynamic var editeDate: NSDate
    
    /*init(id: Int, tittle: String, noteText: String, image: Data) {
        //super.init()
        self.id = id
        self.tittle = tittle
        self.noteText = noteText
        self.image = image
        //self.createDate = NSDate()
        //self.editeDate = NSDate()
        
    }*/
    /*init(id: Int, tittle: String, noteText: String) {
        //super.init()
        self.id = id
        self.tittle = tittle
        self.noteText = noteText
       // self.createDate = NSDate()
        //self.editeDate = NSDate()
    }
 */
}
