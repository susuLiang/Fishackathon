//
//  OutputTableViewController.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit

class OutputTableViewController: UITableViewController {

    enum Component {
        
        case search, scientificName, lowestPrice, highestPrice, averagePrice, priceChart
        
    }
    
    // MARK: Property
    
    private let components: [Component] = [ .search, .lowestPrice, .highestPrice, .averagePrice,  .priceChart]
    
    
    // MARK: View lifr cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        
    }
    
    // MARK: Init
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Set Up
    
    private func setUp() {
        
//        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        
        tableView.register(
            SearchTableViewCell.self,
            forCellReuseIdentifier: SearchTableViewCell.identifier
        )
//        
//        tableView.register(
//            VideoTableViewCell.self,
//            forCellReuseIdentifier: VideoTableViewCell.identifier
//        )
//        
//        tableView.register(
//            ActionTableViewCell.self,
//            forCellReuseIdentifier: ActionTableViewCell.identifier
//        )
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
