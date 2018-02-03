//
//  PostViewController.swift
//  ViewFromXibPractice
//
//  Created by youhsuan on 2018/2/3.
//  Copyright © 2018年 youhsuan. All rights reserved.
//

import UIKit


class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var pickerImageView: UIImageView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    
    let imagePicker = UIImagePickerController()
    
    let date = Date()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.navigationItem.title = "Post My Fish"
        addPhotoButton.addTarget(self, action: #selector(pickImageButton), for: .touchUpInside)
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker))
        timeTextField.inputAccessoryView = toolBar
        timeTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingDidBegin)

    }
    
    let timePickerView = UIDatePicker()
    
    @objc func textFieldEditing(sender: UITextField) {
        
        timePickerView.datePickerMode = .date
        sender.inputView = timePickerView
        timePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        timePickerView.maximumDate = Date()
        timeTextField.text = formatter.string(from: sender.date)
        
    }
    
    @objc func dismissPicker() {

        view.endEditing(true)

    }

    @objc func pickImageButton(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickerImageView.contentMode = .scaleAspectFit
            pickerImageView.image = pickedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickerImageView.contentMode = .scaleAspectFit
            pickerImageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }

   
}

extension PostViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}








