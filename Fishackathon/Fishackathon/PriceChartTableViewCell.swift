//
//  PriceChartTableViewCell.swift
//  Fishackathon
//
//  Created by cindy on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit
import Charts

class PriceChartTableViewCell: UITableViewCell {
    @IBOutlet weak var scatterChart: ScatterChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold, chart: self.scatterChart)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setChart(dataPoints: [String], values: [Double], chart: ScatterChartView) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        let fishPriceDataSet = ScatterChartDataSet(values: dataEntries, label: "Units Sold")
        let fishPriceData = ScatterChartData(dataSet: fishPriceDataSet)
        //        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        //        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        chart.data = fishPriceData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        fishPriceDataSet.colors = colors
        
        
        //        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        //        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        //        lineChartView.data = lineChartData
        
    }

}
