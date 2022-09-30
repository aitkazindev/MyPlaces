//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Ibrahim_ios on 2022/09/29.
//

import UIKit

class NewPlaceTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var currentPlace: Place?
    var imageHasChanged: Bool = false
    
    // MARK:  IBOutlets
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    
    // MARK:  View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setUpEditScreen()
    }
    
    
    // MARK:  Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = UIImage(imageLiteralResourceName: "camera")
            let photoIcon = UIImage(imageLiteralResourceName: "photo")
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default){ _ in
                self.chooseImagePicker(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let photo = UIAlertAction(title: "Photo", style: .default) {_ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet,animated: true)
        }else{
            view.endEditing(true)
        }
    }
    
   
    func savePlace(){
        
        
        var image: UIImage?
        if imageHasChanged{
            image = placeImage.image
        }else{
            image = UIImage(named: "imagePlaceholder")
        }
        
        let imageData = image?.pngData()
        let newPlace = Place(name: nameTextField.text!, location: locationTextField.text, type: typeTextField.text, imageData: imageData)
        
        if currentPlace != nil {
            try! realm.write{
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
            }
        }else{
            StorageManager.saveObject(newPlace)
        }
        
    }

    private func setUpEditScreen() {
        if currentPlace != nil {
            setUpNavigationBar()
            imageHasChanged = true
            guard let data = currentPlace?.imageData,
                  let image = UIImage(data: data) else {return}
            placeImage.image = image
            placeImage.contentMode = .scaleToFill
            nameTextField.text = currentPlace?.name
            locationTextField.text = currentPlace?.location
            typeTextField.text = currentPlace?.type
        }
    }
    
    private func setUpNavigationBar(){
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}






//***************************************************************


// MARK:  Text field delefate

extension NewPlaceTableViewController: UITextFieldDelegate{
    
    // Hiding keyboard after pressing done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged(){
        
        if nameTextField.text?.isEmpty == false{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
}

// MARK:  Work with image

extension NewPlaceTableViewController: UIImagePickerControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFit
        placeImage.clipsToBounds = true
        imageHasChanged = true
        dismiss(animated: true)
        
    }
}
