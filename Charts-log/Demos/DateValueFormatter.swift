//
//  DateValueFormatter.swift
//  graphPG
//
//  Created by thierryH24A on 20/09/2016.
//  Copyright © 2016 thierryH24A. All rights reserved.
//

import Foundation
import Charts

open class DateValueFormatter : NSObject, IAxisValueFormatter
{
    var dateFormatter : DateFormatter
    var miniTime :Double
    
    public init(miniTime: Double) {
        //super.init()
        self.miniTime = miniTime
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd/MM"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        let date2 = Date(timeIntervalSince1970 : (value * 3600 * 24) + miniTime)
        return dateFormatter.string(from: date2)
    }
}
