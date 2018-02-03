//
//  TabBarItemType.swift
//  ChatRoom
//
//  Created by riverciao on 2017/12/3.
//  Copyright © 2017年 riverciao. All rights reserved.
//

// MARK: - TabBarItemType

import UIKit

enum TabBarItemType {
    case market, record
}

// MARK: - Title

extension TabBarItemType {
    
    var title: String {
        
        switch self {
            
        case .market:
            
            return NSLocalizedString("Market", comment: "")
            
        case .record:
            
            return NSLocalizedString("Record", comment: "")
            
        }
        
    }
    
}


// MARK: - Image

extension TabBarItemType {
    
    var image: UIImage {
        
        switch self {
            
        case .market:
            
            return #imageLiteral(resourceName: "icon-chat").withRenderingMode(.alwaysTemplate)
            
        case .record:
            
            return #imageLiteral(resourceName: "icon-blog").withRenderingMode(.alwaysTemplate)
        }
        
    }
    
}


