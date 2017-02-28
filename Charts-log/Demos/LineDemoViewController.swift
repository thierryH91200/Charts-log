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

open class LineDemoViewController: NSViewController
{
    @IBOutlet var lineChartView: LineChartView!
    
    @IBOutlet weak var buttonAxeOX: NSButton!
    @IBOutlet weak var buttonAxeOY: NSButton!
    
    @IBOutlet weak var stickButtonOX: NSButton!
    @IBOutlet weak var stickButtonOY: NSButton!
    
    @IBOutlet weak var stickMajorButtonOX: NSButton!
    @IBOutlet weak var stickMajorButtonOY: NSButton!
    
    @IBOutlet weak var courbe1: NSButton!
    @IBOutlet weak var courbe2: NSButton!
    @IBOutlet weak var courbe3: NSButton!
    
    var logAxeOX = false
    var logAxeOY = false
    
    var stickOX = false
    var stickOY = false
    
    var stickMajorOX = true
    var stickMajorOY = true
    
    var selectCourbe = 0
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        courbe1.state = 1
        stickButtonOX.isEnabled = logAxeOX
        stickButtonOY.isEnabled = logAxeOY
        
        stickMajorButtonOX.isEnabled = logAxeOX
        stickMajorButtonOY.isEnabled = logAxeOY
        
        drawGraph()
    }
    
    open func drawGraph()
    {
        lineChartView.gridBackgroundColor = NSUIColor.white
        lineChartView.chartDescription?.text = "Linechart Lin/log Demo"
        lineChartView.drawGridBackgroundEnabled = true
        lineChartView.drawBordersEnabled = true
        
        let xAxis = lineChartView.xAxis
        xAxis.drawAxisLineEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = CGFloat(-75)
        
        xAxis.labelFont = NSFont.systemFont( ofSize: 10.0)
        xAxis.drawGridLinesEnabled = true
        xAxis.valueFormatter = LogValueFormatter(appendix: "")
        //       xAxis.spaceMin = 0.5
        //       xAxis.spaceMax = 0.5
        
        lineChartView.leftAxis.valueFormatter = LogValueFormatter(appendix: "")
        lineChartView.leftAxis.labelFont = NSFont.systemFont( ofSize: 8.0)
        
        let  marker = XYMarkerView( color: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), font: NSFont.systemFont(ofSize: 12.0),
                                    textColor: NSColor.blue,
                                    insets: NSEdgeInsetsMake(8.0, 8.0, 20.0, 8.0),
                                    xAxisValueFormatter: DoubleAxisValueFormatter(postFixe: "s"),
                                    yAxisValueFormatter: DoubleAxisValueFormatter(postFixe: ""),
                                    logXAxis : logAxeOX, logYAxis: logAxeOY)
        marker.minimumSize = CGSize( width: 80.0, height :40.0)
        lineChartView.marker = marker
        
        // Do any additional setup after loading the view.
        var ys1 = [Double]()
        var ys2 = [Double]()
        var ys3 = [Double]()
        var x1 = [Double]()
        
        switch selectCourbe
        {
        case 0:
            ys1 = Array(stride(from: 1, to: 1e9, by:  1e5)).map { x in return Double(    x     )}
            ys2 = Array(stride(from: 1e9, to: 1, by: -1e5)).map { x in return Double(x )}
            ys3 = Array(stride(from: 1.001, to: 1e9, by:  1e5)).map { x in return log10(Double(x))}
            x1 = Array(stride(from: 1, to: 1e9, by: 1e5)).map { x in return x}
            
        case 1:
            ys1 = Array(stride(from: 20, to: 20000, by: 100)).map { x in return Double(arc4random_uniform(UInt32(100))) + 50}
            ys2 = Array(stride(from: 20, to: 20000, by: 100)).map { x in return Double(arc4random_uniform(UInt32(100))) + 300}
            ys3 = Array(stride(from: 20, to: 20000, by: 100)).map { x in return Double(arc4random_uniform(UInt32(100))) + 700}
            x1 = Array(stride(from: 20, to: 20000, by: 100)).map { x in return x}
            
        case 2:
            ys1 = Array(stride(from: 0.0001, to: 10, by: 0.0005)).map { x in return Double(    x     )}
            ys2 = Array(stride(from: 0.0001, to: 10, by: 0.0005)).map { x in return Double(0.5 * x )}
            ys3 = Array(stride(from: 0.0001, to: 10, by: 0.0005)).map { x in return log10(Double(x))}
            x1 = Array(stride(from: 0.0001, to: 10, by: 0.0005)).map { x in return x}
            
        default:
            ys1 = Array(stride(from: 1, to: 1000, by: 1)).map { x in return Double(    x     )}
            ys2 = Array(stride(from: 1, to: 1000, by: 1)).map { x in return Double(2 * x     )}
            ys3 = Array(stride(from: 1, to: 1000, by: 1)).map { x in return Double(3 * x + 20)}
            x1 = Array(stride(from: 1, to: 1e9, by: 10)).map { x in return x}
            break
        }
        
        let dataInput : [([Double], [Double])] =  [(x1 , ys1),(x1 , ys2), (x1 , ys3)]
        
        lineChartView.xAxis.stickEnabled = stickOX
        lineChartView.leftAxis.stickEnabled = stickOY
        
        lineChartView.xAxis.stickMajorEnabled = stickMajorOX
        lineChartView.leftAxis.stickMajorEnabled = stickMajorOY
        
        lineChartView.xAxis.maskLabels = [true, true, false, true, false, true, false, true, false]
        lineChartView.xAxis.maskAxis =   [1.0 , 2.0  , 3.0  , 4.0  , 5.0  , 6.0  , 7.0  , 8.0  , 9.0]
        
        lineChartView.leftAxis.maskLabels = [true, false, false, false, false, false, false, false, false]
        lineChartView.leftAxis.maskAxis =   [1.0 , 2.0  , 3.0  , 4.0  , 5.0  , 6.0  , 7.0  , 8.0  , 9.0]
        
        lineChartView.leftAxis.logarithmicEnabled = logAxeOY
        lineChartView.xAxis.logarithmicEnabled = logAxeOX
        let dataSets = prepareDataToPlot(dataInput: dataInput, labels: ["y = x", "y = 2x + 10", "y = log(x)"], color: [NSUIColor.green, NSUIColor.red, NSUIColor.black] )
        
        let data = LineChartData()
        for dataSet in dataSets
        {
            data.addDataSet(dataSet)
        }
        
        lineChartView.rightAxis.enabled = false
        lineChartView.data = data
    }
    
    /// function that prepates the data for plotting and setup labels, markers, colors, ...
    ///
    /// - Parameters:
    ///   - dataInput: <#dataInput description#>
    ///   - labels: <#labels description#>
    ///   - marker: <#marker description#>
    ///   - color: <#color description#>
    /// - Returns: <#return value description#>
    public func prepareDataToPlot(dataInput: [([Double], [Double])], labels: [String] = [], color: Array<Any> = [] )->([LineChartDataSet])
    {
        print("start preparing data for plotting")
        var dataInput = dataInput
        
        // setup of markers, colors, ... and their default values if no input is given
        var labels = labels
        var color = color
        var colors = [NSUIColor.black, NSUIColor.blue, NSUIColor.red, NSUIColor.cyan, NSUIColor.green, NSUIColor.magenta, NSUIColor.orange, NSUIColor.magenta, NSUIColor.brown, NSUIColor.yellow]
        
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
                let x  = logAxeOX == true ? log10(dataInput[i].0[j]) : dataInput[i].0[j]
                let y  = logAxeOY == true ? log10(dataInput[i].1[j]) : dataInput[i].1[j]
                dataEntriesSet.append(ChartDataEntry(x: x, y: y))
            }
            dataEntries.append(dataEntriesSet)
        }
        
        // plot apperance set-up
        var lineChartDataSets = [LineChartDataSet]()
        for i in 0..<dataEntries.count
        {
            let lineChartDataSetI = LineChartDataSet(values: dataEntries[i], label: labels[i])
            lineChartDataSetI.colors = [color[i] as! NSColor]
            lineChartDataSetI.drawCirclesEnabled = false
            lineChartDataSetI.lineWidth = 2.0
            //            lineChartDataSetI.mode = .stepped
            lineChartDataSets.append(lineChartDataSetI)
        }
        
        // return processed data to be plotted by plot function
        print("done preparing data for plotting")
        return lineChartDataSets
    }
    
    
    override open func viewWillAppear()
    {
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    @IBAction func ActionAxeOX(_ sender: NSButton)
    {
        logAxeOX = !logAxeOX
        stickButtonOX.isEnabled = logAxeOX
        stickMajorButtonOX.isEnabled = logAxeOX
        
        drawGraph()
    }
    
    @IBAction func ActionAxeOY(_ sender: NSButton) {
        logAxeOY = !logAxeOY
        stickButtonOY.isEnabled = logAxeOY
        stickMajorButtonOY.isEnabled = logAxeOY
        
        drawGraph()
    }
    
    @IBAction func ActionStickAxeOX(_ sender: NSButton)
    {
        stickOX = !stickOX
        drawGraph()
    }
    
    @IBAction func ActionStickAxeOY(_ sender: NSButton)
    {
        stickOY = !stickOY
        drawGraph()
    }
    
    @IBAction func ActionStickMajorAxeOX(_ sender: NSButton)
    {
        stickMajorOX = !stickMajorOX
        drawGraph()
    }
    
    @IBAction func ActionStickMajorAxeOY(_ sender: NSButton)
    {
        stickMajorOY = !stickMajorOY
        drawGraph()
    }
    
    @IBAction func whichRadioButton1(_ sender: NSButton)
    {
        if courbe1.state == 1 {
            selectCourbe = 0
        }
        
        if courbe2.state == 1 {
            selectCourbe = 1
        }
        
        if courbe3.state == 1 {
            selectCourbe = 2
        }
        drawGraph()
    }
}
