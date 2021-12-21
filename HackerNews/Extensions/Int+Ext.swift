//
//  Int+Ext.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/17/21.
//

import Foundation

extension Int {
    func toStringCommentCount() -> String {
        let num = abs(Double(self))

        switch num {
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(formatted)k Comments"

        case 0...:
            return "\(self) " + (self == 1 ? "Comment" : "Comments")

        default:
            return "0 Comments"
        }
    }
}
