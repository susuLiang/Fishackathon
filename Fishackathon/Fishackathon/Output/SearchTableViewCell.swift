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
    
    @IBOutlet weak var searchTextField: UITextField!
    
    class var identifier: String { return String(describing: self) }
    
    static let height: CGFloat = 44.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
        
    }

    // MARK: Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUp()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setUp()

    }
    
    // MARK: Set Up
    
    private func setUp() {
        
        self.contentView.backgroundColor = UIColor.blue
        print("OO\(SearchTableViewCell.identifier)")
//        searchTextField.backgroundColor = .white
        
    }
    
}
