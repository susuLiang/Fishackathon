//
//  PostViewController.swift
//  ViewFromXibPractice
//
//  Created by youhsuan on 2018/2/3.
//  Copyright © 2018年 youhsuan. All rights reserved.
//

import UIKit
import KeychainSwift
import CoreLocation
import Firebase
import SearchTextField

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var fishCommonName: SearchTextField!
   
    let imagePicker = UIImagePickerController()
    var locationManager:CLLocationManager!
    var location: CLLocation?
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var city: String?
    let date = Date()
    let formatter = DateFormatter()
    let timePickerView = UIDatePicker()
    
    let keyChain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.navigationItem.title = "Post My Fish"
        addPhotoButton.addTarget(self, action: #selector(pickImageButton), for: .touchUpInside)
   
        timeTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingDidBegin)
        nameTextField.text = keyChain.get("name")
        getAllFishesCommonNames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineUserCurrentLocation()
    }
    
    func determineUserCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    var allFishNames: [String]? = nil {
        didSet {
            configureFishNameTextField()
        }
    }
    func getAllFishesCommonNames() {
        FirebaseManager.shared.getAllFishesCommonNames { (data, error) in
            self.allFishNames = data
        }
    }
    
    fileprivate func configureFishNameTextField() {
        // Start visible even without user's interaction as soon as created - Default: false.V
        fishCommonName.startVisibleWithoutInteraction = false
        
        // Set data source
        if let allFishNames = self.allFishNames {
            fishCommonName.filterStrings(allFishNames)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let latestLocation = locations.last!
        
        // here check if no need to continue just return still in the same place
        if latestLocation.horizontalAccuracy < 0 {
            return
        }
        // if it location is nil or it has been moved
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            
            location = latestLocation
            // stop location manager
            manager.stopUpdatingLocation()
            
            // Here is the place you want to start reverseGeocoding
            geocoder.reverseGeocodeLocation(latestLocation, completionHandler: { (placemarks, error) in
               
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    self.placemark = placemark.last
                }
                self.parsePlacemarks()
            })
        }
    }
    
    func parsePlacemarks() {
        // here we check if location manager is not nil using a _ wild card
        if let _ = location {
            // unwrap the placemark
            if let placemark = placemark {
                
                if let city = placemark.locality, !city.isEmpty {
                    self.city = city
                    print("\(city)")
                    DispatchQueue.main.async {
                        self.locationTextField.text = "\(city)"
                        self.reloadInputViews()
                    }
                }
            }
            
        } else {
            // add some more check's if for some reason location manager is nil
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
        manager.stopUpdatingLocation()
        locationManager.delegate = nil
        
    }
    
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
    
    var sellInfo: SellData?
    
    @IBAction func updateSellData(_ sender: Any) {
        
        guard let userName = nameTextField.text else {
            presentAlert(withTitle: "No name", message: "no name")
            return}
        guard let priceString = priceTextField.text else {
            presentAlert(withTitle: "Please input price", message: "Please input price")
            return}
        guard let price = Double(priceString) else {
            return}
        guard let time = timeTextField.text else {
            presentAlert(withTitle: "Please input time", message: "Please input time")
            return}
        guard let fishCommonName = fishCommonName.text else {
            presentAlert(withTitle: "Please input fish name", message: "Please input fish name")
            return}
        guard let fishImg = pickerImageView.image else {
            presentAlert(withTitle: "Please upload image", message: "Please upload image")
            return}
        
        var data = Data()
        
        data = UIImageJPEGRepresentation(fishImg, 1)!
        
        
        let storageRef = Storage.storage().reference()
        
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpg"
        
        storageRef.child("\(userName).jpg").putData(data, metadata: metadata) { (metadata, error) in
            
            guard let metadata = metadata else {
                return
            }
            
            guard let downloadURL = metadata.downloadURL()?.absoluteString else {return}
            
            self.sellInfo = SellData.init(userName: userName, sellPrice: price, time: time, fishCommonName: fishCommonName, fishImgUrl: downloadURL)
            
            if let sellInfo = self.sellInfo {
                let value: [String: Any] = [
                    "userName": sellInfo.userName,
                    "sellPrice": sellInfo.sellPrice,
                    "time": sellInfo.time,
                    "fishCommonName": sellInfo.fishCommonName,
                    "fishImg": sellInfo.fishImgUrl]
                
                DispatchQueue.global().async {
                    
                    let ref = Database.database().reference()
                    let sellReference = ref.child("DealRecord").childByAutoId()
                    
                    sellReference.updateChildValues(value, withCompletionBlock: {(err, ref) in
                        if err != nil {
                            print(err)
                            return
                        }
                    })
                }
             }

        }
    }

}

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}









