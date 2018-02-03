//
//  FirebaseManager.swift
//  Fishackathon
//
//  Created by Susu Liang on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import Foundation
import Firebase

enum FirebaseError: Error {
    case cantGetData
}

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    func getFishesCorrespondName(fishCommonName: String, completion: @escaping (String?, Error?) -> Void) {
        Database.database().reference().child("nameCorrespond").observe(.value) { (snapshot: DataSnapshot) in
            if let objects = snapshot.value as? [String: String] {
                  let fishScientificName = objects[fishCommonName]
                  completion(fishScientificName, nil)
            }
        }
        completion(nil, FirebaseError.cantGetData)
    }
}

