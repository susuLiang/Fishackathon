//
//  PriceChartTableViewCell.swift
//  Fishackathon
//
//  Created by Susu Liang on 2018/2/3.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import Foundation
import UIKit
import Charts
import CoreLocation


class PriceChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceChart: CombinedChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        // Set X-Axis to show Month
        priceChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        priceChart.xAxis.granularity = 1
        
        setChart(xValues: months, yValuesLineChart: unitsSold, yValuesBarChart: unitsSold)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setChart(xValues: [String], yValuesLineChart: [Double], yValuesBarChart: [Double]) {
        priceChart.noDataText = "No data for this species of fish"
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()
        var yVals3 : [BarChartDataEntry] = [BarChartDataEntry]()
        priceChart.chartDescription?.text = nil
        
        // Basic set up of plan chart
        
        for i in 0..<xValues.count {
            
            yVals1.append(ChartDataEntry(x: Double(i), y: Double(i)))
            yVals2.append(BarChartDataEntry(x: Double(i), y: Double(i+1)))
            yVals3.append(BarChartDataEntry(x: Double(i), y: Double(i-1)))
            
        }
        
        let averageLineChartSet = LineChartDataSet(values: yVals1, label: "Average Price")
        averageLineChartSet.colors = [UIColor.blue]
        averageLineChartSet.lineWidth = 5.0
        averageLineChartSet.drawCirclesEnabled = false
        
        let maxBarChartSet: BarChartDataSet = BarChartDataSet(values: yVals2, label: "Max Price")
        maxBarChartSet.barBorderWidth = 0.3
        maxBarChartSet.colors = [UIColor.red]
        maxBarChartSet.barShadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0)
        let minBarChartSet: BarChartDataSet = BarChartDataSet(values: yVals3, label: "Min Price")
        minBarChartSet.barBorderWidth = 0.3
        minBarChartSet.colors = [UIColor.green]
        minBarChartSet.barShadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0)
        
        
        let data = CombinedChartData()
        priceChart.leftAxis.axisMinimum = 0
        data.barData = BarChartData(dataSets: [maxBarChartSet,minBarChartSet])
        data.lineData = LineChartData(dataSet: averageLineChartSet)
        priceChart.data = data
        priceChart.backgroundColor = UIColor.brown
        priceChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInCirc)
        priceChart.highlightPerTapEnabled = false

        
    }
    
}
