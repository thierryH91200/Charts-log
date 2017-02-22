//
//  IntAxisValueFormatter.swift
//  graphPG
//
//  Created by thierryH24A on 20/09/2016.
//  Copyright © 2016 thierryH24A. All rights reserved.
//

import Foundation
import Charts

/// Called when a value from an axis is formatted before being drawn.
///
/// For performance reasons, avoid excessive calculations and memory allocations inside this method.
///
/// - returns: The customized label that is drawn on the x-axis.
/// - parameter value:           the value that is currently being drawn
/// - parameter axis:            the axis that the value belongs to
///

open class IntAxisValueFormatter : NSObject, IAxisValueFormatter
{
    open var postFixe :String = ""
    
    public init(postFixe: String)
    {
        self.postFixe = postFixe
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        let str = String(Int(value)) + " " + postFixe
        return str

    }
}
