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

    
    convenience init(id: Int, tittle: String, noteText: String?, image: Data?) {
        self.init()
        self.id = id
        self.tittle = tittle
        self.noteText = noteText
        self.image = image        
    }
}
