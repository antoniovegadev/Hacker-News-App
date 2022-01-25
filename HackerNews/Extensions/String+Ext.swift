//
//  String+Ext.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/14/21.
//

import Foundation
import UIKit
import SwiftSoup

extension String {
    func strippedURL() -> String {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "(?<=/)[^/]+")
        let match = regex.firstMatch(in: self, options: [], range: range)
        if let range = match?.range, let swiftRange = Range(range, in: self) {
            return String(self[swiftRange])
        }

        return self
    }

    func parseHTML() -> String {
        guard let unescaped = try? Entities.unescape(self) else { return self }
        guard let doc: Document = try? SwiftSoup.parse(unescaped) else { return self }
        guard let txt = try? doc.text() else { return self }
        return txt
    }

}
