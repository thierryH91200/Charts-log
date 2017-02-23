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
        
        radarChartView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        radarChartView.chartDescription?.enabled = true
        radarChartView.webLineWidth = 1.0
        radarChartView.innerWebLineWidth = 1.0
        radarChartView.webColor = NSUIColor.lightGray
        radarChartView.innerWebColor = NSUIColor.lightGray
        radarChartView.webAlpha = 1.0
        
        /*       let marker = RadarMarkerView.viewFromXib()
         marker?.chartView = chartView
         chartView.marker = marker*/
        
        let xAxis = radarChartView.xAxis
        xAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0))!
        xAxis.xOffset = 0.0
        xAxis.yOffset = 0.0
        xAxis.labelTextColor = NSUIColor.white
        
        let yAxis = radarChartView.yAxis
        yAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0))!
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0.0
//        yAxis.axisMaximum = 80.0
        yAxis.drawLabelsEnabled = false
        
        let l = radarChartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        l.xEntrySpace = 7.0
        l.yEntrySpace = 5.0
        l.textColor = NSUIColor.white
        
        let mult = 80.0
        let min = 20.0
        let cnt = 5
        var entries1 = [RadarChartDataEntry]()
        var entries2 = [RadarChartDataEntry]()
        // NOTE: The order of the entries when being added to the entries array determines their position around the center of the chart.
        for _ in 0..<cnt
        {
            entries1.append(RadarChartDataEntry(value: (Double(arc4random_uniform(UInt32(mult))) + min)))
            entries2.append(RadarChartDataEntry(value: (Double(arc4random_uniform(UInt32(mult))) + min)))
        }
        
        let set1 = RadarChartDataSet(values: entries1, label: "Last Week")
        set1.colors = [NSUIColor(red: CGFloat(103 / 255.0), green: CGFloat(110 / 255.0), blue: CGFloat(129 / 255.0), alpha: CGFloat(1.0))]
        set1.fillColor = NSUIColor(red: CGFloat(103 / 255.0), green: CGFloat(110 / 255.0), blue: CGFloat(129 / 255.0), alpha: CGFloat(1.0))
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2.0
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(values: entries2, label: "This Week")
        set2.colors = [NSUIColor(red: CGFloat(121 / 255.0), green: CGFloat(162 / 255.0), blue: CGFloat(175 / 255.0), alpha: CGFloat(1.0))]
        set2.fillColor = NSUIColor(red: CGFloat(121 / 255.0), green: CGFloat(162 / 255.0), blue: CGFloat(175 / 255.0), alpha: CGFloat(1.0))
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2.0
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
        let data = RadarChartData(dataSets: [set1, set2])
        data.setValueFont ( NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(8.0)))
        data.setDrawValues ( false )
        data.setValueTextColor(  NSUIColor.white)
        radarChartView.data = data
        
    }
    
    override open func viewWillAppear()
    {
        radarChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeInOutBack)
        
    }
}
