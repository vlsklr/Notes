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
    
    var currentNote: Note!
    var isEditingNote: Bool = false
    var newNoteID = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.isEnabled = false
        isEditingNote = false
        tittleLabel.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // первая ячейка indexPath - imageView
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let imagepickerIcon = #imageLiteral(resourceName: "photo-1")
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                // Метод выбора изображения
                self.chooseImagePicker(source: .camera)
            }
            //добавляем иконку и выравниваем текст для пункта выбора добавляемого фото
            cameraAction.setValue(cameraIcon, forKey: "image")
            cameraAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let photoAction = UIAlertAction(title: "Photo", style: .default) { (_) in
                //Метод съемки фото
                self.chooseImagePicker(source: .photoLibrary)
            }
            //добавляем иконку и выравниваем текст для пункта выбора добавляемого фото
            photoAction.setValue(imagepickerIcon, forKey: "image")
            photoAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
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
    
    private func setupEditScreen() {
        if currentNote != nil {
            guard let data = currentNote?.image, let image = UIImage(data: data) else {
                return
            }
            noteImageView.image = image
            tittleLabel.text = currentNote.tittle
            noteTextLabel.text = currentNote.noteText
            doneBtn.isEnabled = true
        }
    }
    
    
    
    func saveNote() {
        //newNote = Note(id: 1, tittle: tittleLabel.text!, noteText: noteTextLabel.text, image: noteImageView.image!.pngData()!)
        let newNote = Note(id: newNoteID, tittle: tittleLabel.text!, noteText: noteTextLabel.text, image: noteImageView.image!.pngData()!)
        if currentNote != nil{
            try! realm.write{
                currentNote.image = newNote.image
                currentNote.tittle = newNote.tittle
                currentNote.noteText = newNote.noteText
            }
        }else {
            StorageManager.saveObjct(newNote)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        saveNote()
        
        
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
       if (tittleLabel.text?.isEmpty == false) {
            doneBtn.isEnabled = true
        }
        else {
            doneBtn.isEnabled = false
        }
    }
}

//MARK: Работа с изображениямим

extension NewNoteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            //объект делегирует выполнение метода imagePickerController
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    //Метод для подставления снятого(выбранного) изображения в imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        noteImageView.image = info[.editedImage] as? UIImage
        //масштабируем изображение по размеру imageView
        noteImageView.contentMode = .scaleAspectFill
        //обрезка изображения по границе
        noteImageView.clipsToBounds = true
        dismiss(animated: true)
    }
    
    
}
