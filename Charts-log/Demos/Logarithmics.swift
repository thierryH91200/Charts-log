//
//  Logarithmics.swift
//  Charts
//
//  Created by thierryH24A on 12/01/2017.
//
//

import Foundation

open class Logarithmic
{    
    open class func makingDataLog(_ dataInput:  inout [([Double], [Double])], logAxeOX : Bool = false, logAxeOY : Bool = false)
    {
        // make data logarithmic
        if logAxeOX == true
        {
            print("\tstart making X-axis data logarithmic")
            
            // cycle through the data, shift them into the positive (>1) range and calculate the log values. 
            // entries with x value = 0.0 are deleted (also the acording y entry)
            for i in 0..<dataInput.count
            {
                var xDataInputLogTemp: [Double] = []
                
                for j in 0..<dataInput[i].0.count
                {
                    let xEntry = dataInput[i].0[j]
                    if xEntry > 0
                    {
                        xDataInputLogTemp.append(log10(xEntry))
                    }
                    else
                    {
                        dataInput[i].1.remove(at: j)
                    }
                }
                dataInput[i].0 = xDataInputLogTemp
            }
            print("\tdone making X-axis data logarithmic")
        }
        
        if logAxeOY == true
        {
            print("\tstart making Y-axis data logarithmic")
            
            // cycle through the data, shift them into the positive (>1) range and calculate the log values.
            // entries with x value = 0.0 are deleted (also the acording y entry)
            for i in 0..<dataInput.count
            {
                var yDataInputLogTemp: [Double] = []
                for j in 0..<dataInput[i].1.count
                {
                    let yEntry = dataInput[i].1[j]
                    if yEntry > 0
                    {
                        yDataInputLogTemp.append(log10(yEntry))
                    }
                    else
                    {
                        dataInput[i].0.remove(at: j)
                    }
                }
                dataInput[i].1 = yDataInputLogTemp
            }
            print("\tdone making Y-axis data logarithmic")
        }
    }
}
