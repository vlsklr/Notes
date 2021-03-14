//
//  NewNoteVC.swift
//  Notes
//
//  Created by Vlad on 14.03.2021.
//

import UIKit

class NewNoteVC: UITableViewController {

    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var tittleLabel: UITextField!
    @IBOutlet weak var noteTextLabel: UITextView!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.isEnabled = false
        tittleLabel.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    
    }
    
    
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        
    }
    
}

//Скрывает клавиатуру по нажатию на Done
extension NewNoteVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged(){
        if tittleLabel.text?.isEmpty == false {
            doneBtn.isEnabled = true
        }
        else {
            doneBtn.isEnabled = false
        }
    }
}
