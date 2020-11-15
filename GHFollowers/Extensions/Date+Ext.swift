//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Aya on 10/22/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

extension Date{
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    
}
