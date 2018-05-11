//
//  DateFormatter.swift
//  Openweather
//
//  Created by Oleksii Horishnii on 4/27/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

// since it's pretty heavy task to initialize one
class DateFormatterManager: NSObject {
    public static let shared = DateFormatterManager()
    
    let formatter = DateFormatter()
    
    public func dateToTime(_ date: Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    public func dateToDay(_ date: Date) -> String {
        formatter.dateFormat = "dd MMMM yyyy";
        return formatter.string(from: date)
    }
}

extension Date {
    func toTime() -> String {
        return DateFormatterManager.shared.dateToTime(self)
    }
    
    func toDay() -> String {
        return DateFormatterManager.shared.dateToDay(self)
    }
}
