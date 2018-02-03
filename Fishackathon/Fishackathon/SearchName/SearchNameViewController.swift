//
//  SearchNameViewController.swift
//  Fishackathon
//
//  Created by riverciao on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit
import SearchTextField
import Charts

class SearchNameViewController: UIViewController {
    
    // MARK: Properties
    
    var allFishNames: [String]? = nil {
        didSet {
            configureFishNameTextField()
        }
    }
    
    @IBOutlet weak var fishNameSearchTextField: SearchTextField!
    
    @IBOutlet weak var scientificName: UILabel!
    
    @IBOutlet weak var chartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartTableView.delegate = self
        chartTableView.dataSource = self
        
        setup()
        getAllFishesCommonNames()
        
    }
    
    func setup() {
        
        chartTableView.register(UINib(nibName: "PriceChartTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceChartTableViewCell")
        
        fishNameSearchTextField.theme.bgColor = .white
        
        fishNameSearchTextField.addTarget(self, action: #selector(search), for: .editingDidEnd)
        
    }
    
    func getAllFishesCommonNames() {
        FirebaseManager.shared.getAllFishesCommonNames { (data, error) in
            self.allFishNames = data
        }
    }
    
    fileprivate func configureFishNameTextField() {
        // Start visible even without user's interaction as soon as created - Default: false.V
        fishNameSearchTextField.startVisibleWithoutInteraction = true
        
        // Set data source
        if let allFishNames = self.allFishNames {
            fishNameSearchTextField.filterStrings(allFishNames)
        }

    }
    
    @objc func search() {
        
        if let commonName = fishNameSearchTextField.text {
            
            FirebaseManager.shared.getFishesCorrespondName(fishCommonName: commonName, completion: { (data, error) in
                
                if let error = error {
                    
                    print("invalid fish common name \(error)")
                
                    return
                }
                
                guard let data = data else {
                    
                    print("data not exist")
                    
                    return
                }
                
                self.scientificName.text = data
                
            })
            
            
        }
        
    }

}

extension SearchNameViewController: UITableViewDelegate, UITableViewDataSource, ChartViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceChartTableViewCell", for: indexPath) as! PriceChartTableViewCell
        cell.priceChart.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.chartTableView.bounds.height
    }

    
}

