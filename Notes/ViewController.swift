//
//  ViewController.swift
//  Notes
//
//  Created by Vlad on 12.03.2021.
//

import UIKit
import RealmSwift


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var notes: Results<Note>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = realm.objects(Note.self)
        if notes.isEmpty {
            generateNote()
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! CustomTableViewCell
        let note = notes[indexPath.row]
        cell.tittleLabel.text = note.tittle
        cell.noteTextLabel.text = note.noteText
        
        return cell
    }
    
    private func generateNote() {
        let note = Note()
        note.id = 1
        note.noteText = "NoteTxt"
        note.tittle = "test tittle"
        StorageManager.saveObjct(note)
    }



}

