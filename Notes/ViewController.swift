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
        //заполнение базы при первом запуске приложения
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
        } else {
            generateNote()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let newNoteVC = segue.destination as! NewNoteVC
        newNoteVC.newNoteID = notes.count + 1
        
        if segue.identifier == "showNote" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let note = notes[indexPath.row]
            newNoteVC.currentNote = note
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notes[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {_, _, complete in
            StorageManager.deleteObject(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
            
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        tableView.reloadData()
        return configuration
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func generateNote() {
        
        let note = Note(id: 1, tittle: "NotTittle", noteText: "NoteText", image: UIImage(named: "Camera")?.pngData())
        StorageManager.saveObjct(note)
    }



}

