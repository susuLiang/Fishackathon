//
//  SellData.swift
//  Fishackathon
//
//  Created by youhsuan on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import Foundation
import UIKit

struct SellData: Codable {
    let userName: String
    let sellPrice: Double
    let time: String
    let fishCommonName: String
    let fishImgUrl: String
    
    init(userName: String, sellPrice: Double, time: String, fishCommonName: String, fishImgUrl: String) {
        self.userName = userName
        self.sellPrice = sellPrice
        self.time = time
        self.fishCommonName = fishCommonName
        self.fishImgUrl = fishImgUrl
    }
    
}

