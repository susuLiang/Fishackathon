//
//  SearchTableViewCell.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, Identifiable {

    // MARK: Property
    
    class var identifier: String { return String(describing: self) }
    
    static let height: CGFloat = 44.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
