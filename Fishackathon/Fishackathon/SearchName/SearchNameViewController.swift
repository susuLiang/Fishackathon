//
//  SearchNameViewController.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit

class SearchNameViewController: UIViewController {
    
    let fishNameManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        
        fishNameManager.getFishesCorrespondName(fishCommonName: "Agassiz's dwarf cichlid") { (fishName, error) in
            
            print("OO\(fishName)")
            
        }
        
    }


}
