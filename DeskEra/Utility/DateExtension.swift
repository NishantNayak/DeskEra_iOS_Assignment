//
//  DateExtension.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 23/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import Foundation

extension Date{
    func returnNextDate() -> Date{
        let nowDate = Calendar.current.startOfDay(for: self)
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nowDate, wrappingComponents: false)
        return nextDate!
    }
    
    func returnPreviousDate() -> Date{
        let nowDate = Calendar.current.startOfDay(for: self)
        let nextDate = Calendar.current.date(byAdding: .day, value: -1, to: nowDate, wrappingComponents: false)
        return nextDate!
    }
    
    func dateToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self)
        
        return dateString
    }
}

extension String{
    func stringToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:self)
        return date
    }
}
