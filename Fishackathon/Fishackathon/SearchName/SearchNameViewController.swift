
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

class SearchNameViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var allFishNames: [String]? = nil {
        didSet {
            DispatchQueue.main.async {
                self.configureFishNameTextField()
            }
        }
    }
    
    @IBOutlet weak var fishNameSearchTextField: SearchTextField!
    
    @IBOutlet weak var scientificName: UILabel!
    
    @IBOutlet weak var chartTableView: UITableView!
    
    var datas:[SellData] = []
    
    var photoRecognizeName: String?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        FirebaseManager.shared.getFishRecords(fishCommonName: textField.text!) { [weak self](data, error) in
            if error == nil {
                self?.datas = data!
                self?.chartTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Possible Fish", comment: "")
        chartTableView.delegate = self
        chartTableView.dataSource = self
        fishNameSearchTextField.delegate = self
        
        setup()
        getAllFishesCommonNames()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let name = photoRecognizeName {
            scientificName.text = name
            FirebaseManager.shared.getFishRecords(fishCommonName: photoRecognizeName!) { [weak self] (data, error)  in

            }
        }
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
        fishNameSearchTextField.startVisibleWithoutInteraction = false
        
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
                
//                FirebaseManager.shared.getFishRecords(fishCommonName: data, completion: {(data, error) in
//                    print(data)
//
//                    })
                
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
        let diceRoll = Int(arc4random_uniform(12))
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        cell.unitsSold = []
//        for _ in 0..<self.datas.count {
//            cell.unitsSold.append(self.datas[indexPath.row].sellPrice)
//            cell.months.append(months[diceRoll-1])
//        }
//        cell.setChart(xValues: cell.months, yValuesLineChart: cell.unitsSold, yValuesBarChart: cell.unitsSold)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.chartTableView.bounds.height
    }

}

