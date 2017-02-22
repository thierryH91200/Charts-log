//
//  RadarDemoViewController.swift
//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
import Foundation
import Cocoa
import Charts

open class RadarDemoViewController: NSViewController
{
    @IBOutlet var radarChartView: RadarChartView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        let entries = [
            RadarChartDataEntry(value: 0.8),
            RadarChartDataEntry(value: 1.8),
            RadarChartDataEntry(value: 2.8),
            RadarChartDataEntry(value: 3.8),
            RadarChartDataEntry(value: 4.8),
            RadarChartDataEntry(value: 5.8)
       ]
        
        let data = RadarChartData()
        
        let dataSet = RadarChartDataSet(values: entries, label: nil)
        dataSet.drawFilledEnabled = true
        dataSet.drawValuesEnabled = false
        
        data.addDataSet(dataSet)
        
        self.radarChartView.data = data
        
        
        // Do any additional setup after loading the view.
        /*       let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
         let ys2 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
         
         let yse1 = ys1.enumerated().map { x, y in return RadarChartDataEntry(value: y) }
         let yse2 = ys2.enumerated().map { x, y in return RadarChartDataEntry(value: y) }
         
         let data = RadarChartData()
         let ds1 = RadarChartDataSet(values: yse1, label: "Hello")
         ds1.colors = [NSUIColor.red]
         data.addDataSet(ds1)
         
         let ds2 = RadarChartDataSet(values: yse2, label: "World")
         ds2.colors = [NSUIColor.blue]
         data.addDataSet(ds2)
         self.radarChartView.data = data
         self.radarChartView.chartDescription?.text = "Radarchart Demo"*/
        
    }
    
    override open func viewWillAppear()
    {
        self.radarChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
}
