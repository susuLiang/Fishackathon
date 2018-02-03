//
//  PossibleFishesCell.swift
//  Fishackathon
//
//  Created by Susu Liang on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit

class PossibleFishesCell: UITableViewCell {

    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var commonName: UILabel!
    @IBOutlet weak var scientificName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
