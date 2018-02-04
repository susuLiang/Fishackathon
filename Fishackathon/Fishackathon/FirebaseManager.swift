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
    case cantPostData
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

    func getAllFishesCommonNames(completion: @escaping ([String]?, Error?) -> Void) {
        Database.database().reference().child("nameCorrespond").observe(.value) { (snapshot: DataSnapshot) in
            
            var fishCommonNames: [String] = []
            
            if let objects = snapshot.value as? [String: String] {
                for fishCommonName in objects.keys {
                    fishCommonNames.append(fishCommonName)
                }
            }
            completion(fishCommonNames, nil)
        }
        completion(nil, FirebaseError.cantGetData)
    }
    
    func getFishesCorrespondCommonName(fishScientificName: String, completion: @escaping (String?, Error?) -> Void) {
        Database.database().reference().queryOrdered(byChild: "nameCorrespond").queryEqual(toValue: fishScientificName).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
            if let objects = snapshot.value as? [String: String] {
                print(objects)
//                let fishCommonName = objects.keys
//                completion(fishCommonName, nil)
            }
        }
        completion(nil, FirebaseError.cantGetData)
    }
    
    func getFishRecords(fishCommonName: String, completion: @escaping ([SellData]?, Error?) -> Void) {
        Database.database().reference().child("DealRecord").queryOrdered(byChild: "fishCommonName").queryEqual(toValue: fishCommonName).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            print(snapshot)
            if let objects = snapshot.value as? [String: String] {
                print(objects)
                //                let fishCommonName = objects.keys
                //                completion(fishCommonName, nil)
            }
        }
        completion(nil, FirebaseError.cantGetData)
    }


}

