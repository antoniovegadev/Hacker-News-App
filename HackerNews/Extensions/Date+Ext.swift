//
//  Date+Ext.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import Foundation

extension Date {
    func relativeStringDate() -> String {
        let fromDate = self
        let toDate = Date()
        let diffComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: fromDate, to: toDate)

        let years = diffComponents.year ?? 0
        let months = diffComponents.month ?? 0
        let days = diffComponents.day ?? 0
        let hours = diffComponents.hour ?? 0
        let minutes = diffComponents.minute ?? 0

        if years > 0 {
            return "\(years)y"
        } else if months > 0 {
            return "\(months)mo"
        } else if days > 0 {
            return "\(days)d"
        } else if hours > 0 {
            return "\(hours)h"
        } else if minutes > 0 {
            return "\(minutes)m"
        } else {
            return "0m"
        }
    }
}
