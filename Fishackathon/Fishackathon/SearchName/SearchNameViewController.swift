//
//  SearchNameViewController.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit

class SearchNameViewController: UIViewController {
    
    var allFishNames: [String: String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        
        FirebaseManager.shared.getAllFishesCorrespondName { (data, error) in
            
            self.allFishNames = data
            
            print("all\(self.allFishNames)")
            
        }
        
    }


}
