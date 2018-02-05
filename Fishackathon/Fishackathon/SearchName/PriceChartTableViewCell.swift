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
    
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var unitsSoldmax = [19.0, 20.0, 15.2, 17.0, 12.0, 11.5, 20.2, 16.0,11.0,15.0, 6.0, 17.0]
    var unitsSold = [12.0, 15.0, 13.2, 14.0, 9.5, 10.5, 17.2, 15,9.0,11.0, 12.0, 13.0]
    var unitsSoldmin = [8.0, 6.0, 7.2, 9.0, 9.0, 7.5, 13.2, 12.0,7.0,10.0, 9.0, 12.0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set X-Axis to show Month
        priceChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        priceChart.xAxis.granularity = 1
        priceChart.setScaleMinima(1, scaleY: 0.3)
        
        setChart(xValues: months, yValuesLineChart: unitsSold, yValuesMinBarChart: unitsSold, yValuesMaxBarChart: unitsSoldmax)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setChart(xValues: [String], yValuesLineChart: [Double], yValuesMinBarChart: [Double], yValuesMaxBarChart: [Double]) {
        priceChart.noDataText = "No data for this species of fish"
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()
        var yVals3 : [BarChartDataEntry] = [BarChartDataEntry]()
        priceChart.chartDescription?.text = nil
        
        // Basic set up of plan chart
        
        for i in 0..<xValues.count {
            
            yVals1.append(ChartDataEntry(x: Double(i), y: Double(yValuesLineChart[i])))
            yVals2.append(BarChartDataEntry(x: Double(i), y: Double(yValuesMaxBarChart[i])))
            yVals3.append(BarChartDataEntry(x: Double(i), y: Double(yValuesMinBarChart[i])))
            
        }
        
        let averageLineChartSet = LineChartDataSet(values: yVals1, label: "Average Price")
        averageLineChartSet.colors = [UIColor(displayP3Red: 224/255.0, green: 241/255.0, blue: 187/255.0, alpha: 1)]
        averageLineChartSet.lineWidth = 5.0
        averageLineChartSet.drawCirclesEnabled = false
        
        let maxBarChartSet: BarChartDataSet = BarChartDataSet(values: yVals2, label: "Max Price")
        maxBarChartSet.barBorderWidth = 0.3
        maxBarChartSet.colors = [UIColor(displayP3Red: 43/255.0, green: 158/255.0, blue: 179/255.0, alpha: 1)]
//        maxBarChartSet.barShadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0)
        
        let minBarChartSet: BarChartDataSet = BarChartDataSet(values: yVals3, label: "Min Price")
//        minBarChartSet.barBorderWidth = 0.3
        minBarChartSet.colors = [UIColor(displayP3Red: 230/255.0, green: 235/255.0, blue: 224/255.0, alpha: 1)]
//        minBarChartSet.barShadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0)
        
        
        let data = CombinedChartData()
        priceChart.leftAxis.axisMinimum = 0
        data.barData = BarChartData(dataSets: [maxBarChartSet,minBarChartSet])
        data.lineData = LineChartData(dataSet: averageLineChartSet)
        priceChart.data = data
        priceChart.backgroundColor = UIColor(displayP3Red: 230/255.0, green: 235/255.0, blue: 224/255.0, alpha: 1)
        priceChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInCirc)
        priceChart.highlightPerTapEnabled = false

        
    }
    
}
