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
        Database.database().reference().child("nameCorrespond").observe(.value) {
                (snapshot: DataSnapshot) in
            DispatchQueue.global().async {
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
        print(fishCommonName)
        Database.database().reference().child("DealRecord")
            .queryOrdered(byChild: "fishCommonName")
            .queryEqual(toValue: fishCommonName)
//            .queryEqual(toValue: "Almoloya cichlid", childKey: "fishCommonName")
            .observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            print(snapshot.value)
            
            
            if let objects = snapshot.value as? [String: Any] {
//                for object in objects {
                var sellDatas: [SellData] = []
                    for (key, new) in objects {
                        print("key:", key)
                        guard let value = new as? [String: Any]
                            else { return }
                        let commonName = value["fishCommonName"] as! String
                        let fishImg = value["fishImg"] as! String
                        let sellPrice = value["sellPrice"] as! Double
                        let time = value["time"] as! String
                        let userName = value["userName"] as! String
                        let data = SellData(userName: userName, sellPrice: sellPrice, time: time, fishCommonName: commonName, fishImgUrl: fishImg)
                        sellDatas.append(data)
                    }
                    completion(sellDatas, nil)
                }
                //                let fishCommonName = objects.keys
                //                completion(fishCommonName, nil)
//            }
        }
        completion(nil, FirebaseError.cantGetData)
    }


}

