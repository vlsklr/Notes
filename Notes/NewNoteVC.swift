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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // первая ячейка indexPath - imageView
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                // Метод выбора изображения
                self.chooseImagePicker(source: .camera)
            }
            let photoAction = UIAlertAction(title: "Photo", style: .default) { (_) in
                //Метод съемки фото
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(photoAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true)
            
        }
        //скрывается клавиатура, если тапнуть вне поля
        else {
            view.endEditing(true)
        }
    }
    
    
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        
    }
    
}

//Скрывает клавиатуру по нажатию на Done
extension NewNoteVC: UITextFieldDelegate {
    //Скрытие клавиатуры по нажатию на done клавиатуры
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //активирует кнопку Done при вводе tittle
    @objc private func textFieldChanged(){
        if tittleLabel.text?.isEmpty == false {
            doneBtn.isEnabled = true
        }
        else {
            doneBtn.isEnabled = false
        }
    }
}

//MARK: Работа с изображениямим

extension NewNoteVC {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    
}
