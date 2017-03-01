//
//  LineDemoViewController.swift
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

open class LineDateViewController: NSViewController
{
    @IBOutlet var lineChartView: LineChartView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        let xAxis = lineChartView.xAxis
        xAxis.granularityEnabled = true
        xAxis.granularity = 1.0
//        xAxis.granularity = 3600.0 * 24.0
        
        xAxis.spaceMin = xAxis.granularity / 5
        xAxis.spaceMax = xAxis.granularity / 5
        
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = false
        
        xAxis.gridLineDashPhase = 2
        xAxis.gridLineDashLengths =  [1,3,4,2]
        
        xAxis.labelPosition = .bottom
        
        lineChartView.leftAxis.gridLineDashPhase = 2
        lineChartView.leftAxis.gridLineDashLengths =  [1,3,4,2]
        
        // Do any additional setup after loading the view.
        let ys1 = Array(0..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        
        let visitor = ["01-04-2016 00:00", "02-04-2016 00:00", "03-04-2016 00:00","04-04-2016 00:00", "07-04-2016 00:00", "11-04-2016 00:00", "15-04-2016 00:00", "17-04-2016 00:00", "18-04-2016 00:00", "19-04-2016 00:00"]
        
 //       let visitor = ["07-03-2016", "08-03-2016", "10-03-2016","11-03-2016"]
 
        var dataEntries: [ChartDataEntry] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        
        var miniDate : Double = 0.0
        for i in 0..<visitor.count
        {
            let myDateMidnightLocalTime = dateFormatter.date(from: visitor[i])!
            let timeInSeconds = myDateMidnightLocalTime.timeIntervalSince1970
            if i == 0
            {
                miniDate = timeInSeconds
            }
           let dataEntry = BarChartDataEntry(x: (timeInSeconds - miniDate) / (3600.0 * 24.0), y: ys1[i])
 //          let dataEntry = BarChartDataEntry(x: (timeInSeconds - miniDate) , y: ys1[i])

            dataEntries.append(dataEntry)
        }
        xAxis.labelCount = visitor.count * 2
        xAxis.labelRotationAngle = -90.0
        xAxis.valueFormatter = DateValueFormatter(miniTime : miniDate)
     
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: dataEntries, label: "Hello")
        ds1.colors = [NSUIColor.red]
        ds1.mode = .stepped
        ds1.drawCirclesEnabled = false
        ds1.lineWidth = 2.0
        ds1.highlightColor = .green
        ds1.highlightLineWidth = 1.0
        data.addDataSet(ds1)
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white
        lineChartView.drawGridBackgroundEnabled = true
        lineChartView.drawBordersEnabled = true
        lineChartView.rightAxis.enabled = false
        
        
        let  marker = XYMarkerView( color: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), font: NSFont.systemFont(ofSize: 12.0),
                                    textColor: NSColor.blue,
                                    insets: NSEdgeInsetsMake(8.0, 8.0, 20.0, 8.0),
                                    xAxisValueFormatter: DateValueFormatter(miniTime: miniDate),
                                    yAxisValueFormatter: DoubleAxisValueFormatter(postFixe: ""))
        marker.minimumSize = CGSize( width: 80.0, height :40.0)
        lineChartView.marker = marker

        self.lineChartView.chartDescription?.text = "Line Date Demo"
        self.lineChartView.data = data
    }
    
    override open func viewWillAppear()
    {
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
}


