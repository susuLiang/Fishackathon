//
//  InputOptionViewController.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import KeychainSwift
import Fusuma

class InputOptionViewController: UIViewController {

    // MARK: Property
    
    let keyChain = KeychainSwift()
    
    let fusuma = FusumaViewController()
    
    @IBOutlet weak var fishNameButton: UIButton!

    @IBOutlet weak var fishPictureButton: UIButton!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonAppearence()
        setupButtonAction()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    // MARK: Setup
    
    func setUpButtonAppearence() {
        fishNameButton.layer.cornerRadius = 5
        fishNameButton.clipsToBounds = true
        fishPictureButton.layer.cornerRadius = 5
        fishPictureButton.clipsToBounds = true
    }
    
    func setupButtonAction() {
        
        fishNameButton.addTarget(self, action: #selector(searchByFishName), for: .touchUpInside)
        
        fishPictureButton.addTarget(self, action: #selector(searchByFishPicture), for: .touchUpInside)
        
    }
    
    @objc func searchByFishName() {
        
        let searchNameViewController = SearchNameViewController()
        self.navigationController?.pushViewController(searchNameViewController, animated: true)
    
    }
    
    @objc func searchByFishPicture() {
        fusuma.delegate = self
        fusuma.cropHeightRatio = 0.8
        fusuma.allowMultipleSelection = false

        self.present(fusuma, animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton(NSLocalizedString("SURE", comment: ""), action: {
            self.keyChain.clear()
            do {
                try Auth.auth().signOut()
            } catch let logoutError {
                print(logoutError)
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController = storyboard.instantiateViewController(withIdentifier: "loginController")
            self.present(loginController, animated: true, completion: nil)
            
        })
        alertView.addButton(NSLocalizedString("NO", comment: "")) {}
        alertView.showWarning(NSLocalizedString("Sure to log out ?", comment: ""), subTitle: "")
    }
}

extension InputOptionViewController: FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        guard let possibleFishesViewController = UINib.load(nibName: "PossibleFishesViewController") as? PossibleFishesViewController else {
            print("PossibleFishesViewController load failed.")
            return
        }
        possibleFishesViewController.photo.image = image
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(possibleFishesViewController, animated: true)
            
        }
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        
    }
    
}
