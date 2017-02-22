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

open class ScatterDemoViewController: NSViewController
{
    @IBOutlet var scatterChartView: ScatterChartView!
    
    @IBOutlet weak var buttonAxeOX: NSButton!
    @IBOutlet weak var buttonAxeOY: NSButton!
    
    var logAxeOX = false
    var logAxeOY = false
    
    var dataInput : [([Double], [Double])] = []
    
    var selectCourbe = 0
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        drawGraph()
        drawData()
    }
    
    open func drawGraph()
    {
        scatterChartView.gridBackgroundColor = NSUIColor.white
        scatterChartView.chartDescription?.text = "Scatterchart Lin/log Demo"
        scatterChartView.drawGridBackgroundEnabled = true
        scatterChartView.drawBordersEnabled = true
        
        let xAxis = scatterChartView.xAxis
        xAxis.drawAxisLineEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = CGFloat(-45)
        
        xAxis.labelFont = NSFont.systemFont( ofSize: 10.0)
        xAxis.drawGridLinesEnabled = true
        xAxis.valueFormatter = DoubleAxisValueFormatter(postFixe: "")
        xAxis.spaceMin = 0.5
        xAxis.spaceMax = 0.5
        
        scatterChartView.leftAxis.valueFormatter = DoubleAxisValueFormatter(postFixe: "")
        scatterChartView.rightAxis.enabled = false
        
        // Do any additional setup after loading the view.
        var ys1 = [Double]()
        var ys2 = [Double]()
        var ys3 = [Double]()
        var x1  = [Double]()
        var x2  = [Double]()
        var x3  = [Double]()
        
        let range : UInt32 = 1000
        
        for i in 0..<25
        {
            var val = Double(arc4random_uniform(range)) + 3
            ys1.append(val)
            x1.append(Double(i))
            val = Double(arc4random_uniform(range)) + 3
            ys2.append(val)
            x2.append(Double(i) + 0.33)
            val = Double(arc4random_uniform(range)) + 3
            ys3.append(val)
            x3.append(Double(i) + 0.66)
        }
        //       let dataInput : [([Double], [Double])] =  [(x1 , ys1),(x2 , ys1), (x3 , ys1)]
        dataInput  =  [(x1 , ys1)]
    }
    
    open func drawData()
    {
        let  marker = XYMarkerView( color: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), font: NSFont.systemFont(ofSize: 12.0),
                                    textColor: NSColor.blue,
                                    insets: NSEdgeInsetsMake(8.0, 8.0, 20.0, 8.0),
                                    xAxisValueFormatter: DoubleAxisValueFormatter(postFixe: ""),
                                    yAxisValueFormatter: DoubleAxisValueFormatter(postFixe: ""),
                                    logXAxis : logAxeOX, logYAxis: logAxeOY)
        marker.minimumSize = CGSize( width: 80.0, height :40.0)
        scatterChartView.marker = marker

        scatterChartView.leftAxis.logarithmicEnabled = logAxeOY
        scatterChartView.xAxis.logarithmicEnabled = logAxeOX
        
        let dataSets = prepareDataToPlot(dataInput: dataInput, labels: ["y = random(x)"], marker: [], color: [NSUIColor.green, NSUIColor.red, NSUIColor.black] )
        
        let data = ScatterChartData()
        for dataSet in dataSets
        {
            data.addDataSet(dataSet)
        }
        scatterChartView.leftAxis.forceLabelsEnabled = false
        scatterChartView.data = data
    }
    
    /// function that prepates the data for plotting and setup labels, markers, colors, ...
    ///
    /// - Parameters:
    ///   - dataInput: <#dataInput description#>
    ///   - labels: <#labels description#>
    ///   - marker: <#marker description#>
    ///   - color: <#color description#>
    ///   - logX: <#logX description#>
    ///   - logY: <#logY description#>
    /// - Returns: <#return value description#>
    public func prepareDataToPlot(dataInput: [([Double], [Double])], labels: [String] = [], marker: Array<ScatterChartDataSet.Shape> = [], color: Array<Any> = [] )->([ScatterChartDataSet])
    {
        print("start preparing data for plotting")
        var dataInput = dataInput
        Logarithmic.makingDataLog( &dataInput, logAxeOX: logAxeOX, logAxeOY: logAxeOY)
        
        // setup of markers, colors, ... and their default values if no input is given
        var labels = labels
        var color = color
        var colors = [NSUIColor.blue, NSUIColor.black, NSUIColor.red, NSUIColor.cyan, NSUIColor.green, NSUIColor.magenta, NSUIColor.orange, NSUIColor.magenta, NSUIColor.brown, NSUIColor.yellow]
        
        // (Marker) Color set-up
        if color.count != dataInput.count
        {
            color = []
            if dataInput.count < colors.count
            {
                for i in 0..<dataInput.count
                {
                    color.append(colors[i])
                }
            } else
            {
                var counter = 0
                for _ in 0..<dataInput.count
                {
                    color.append(colors[counter])
                    if counter == colors.endIndex
                    {
                        counter = 0
                    }
                }
            }
        }
        
        // Marker set-up
        var marker = marker
        if marker.count != dataInput.count {
            marker = []
            for _ in 0..<dataInput.count {
                marker.append(ScatterChartDataSet.Shape.x)
            }
        }
        
        // Description lable set-up
        if labels.count != dataInput.count
        {
            labels = [String](repeating: "-", count: dataInput.count)
        }
        
        // chart data set-up
        var dataEntries: [[ChartDataEntry]] = []
        for i in 0..<dataInput.count
        {
            var dataEntriesSet: [ChartDataEntry] = []
            for j in 0..<dataInput[i].0.count
            {
                dataEntriesSet.append(ChartDataEntry(x: dataInput[i].0[j], y: dataInput[i].1[j]))
            }
            dataEntries.append(dataEntriesSet)
        }
        
        // plot apperance set-up
        var scatterChartDataSets: [ScatterChartDataSet] = []
        for i in 0..<dataEntries.count
        {
            let scatterChartDataSetI = ScatterChartDataSet(values: dataEntries[i], label: labels[i])
            scatterChartDataSetI.colors = [color[i] as! NSColor]
            scatterChartDataSetI.setScatterShape(marker[i])
            scatterChartDataSetI.drawValuesEnabled = false
            scatterChartDataSets.append(scatterChartDataSetI)
        }
        
        // return processed data to be plotted by plot function
        print("done preparing data for plotting")
        return scatterChartDataSets
    }
    
    override open func viewWillAppear()
    {
        scatterChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    @IBAction func ActionAxeOX(_ sender: NSButton)
    {
        logAxeOX = !logAxeOX
        drawData()
    }
    
    @IBAction func ActionAxeOY(_ sender: NSButton) {
        logAxeOY = !logAxeOY
        drawData()
    }
    
    @IBAction func buttonShuffle(_ sender: Any)
    {
        drawGraph()
        drawData()
    }
}
