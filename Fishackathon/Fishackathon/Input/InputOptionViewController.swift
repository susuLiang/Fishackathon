//
//  InputOptionViewController.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit

class InputOptionViewController: UIViewController {

    // MARK: Property
    
    @IBOutlet weak var fishNameButton: UIButton!

    @IBOutlet weak var fishPictureButton: UIButton!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        setup()
        
    }
    
    // MARK: Setup
    
    func setup() {
        
        fishNameButton.addTarget(self, action: #selector(searchByFishName), for: .touchUpInside)
        
        fishPictureButton.addTarget(self, action: #selector(searchByFishPicture), for: .touchUpInside)
        
    }
    
    @objc func searchByFishName() {
        
        print("123")
    
    }
    
    @objc func searchByFishPicture() {
        
        print("picture")
        
    }
    
}
