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

    func attributedString() -> NSMutableAttributedString {
        guard let unescaped = try? Entities.unescape(self) else { return NSMutableAttributedString(string: self) }
        var ret = unescaped.replacingOccurrences(of: "<p>", with: "\n\n")

        guard let doc: Document = try? SwiftSoup.parse(self),
              let body: SwiftSoup.Element = doc.body(),
              let links: SwiftSoup.Elements = try? body.select("a"),
              let code: SwiftSoup.Elements = try? body.select("pre"),
              let italics: SwiftSoup.Elements = try? body.select("i")
        else { return NSMutableAttributedString(string: self) }

        for link in links.array() {
            let outerHtml = try! Entities.unescape(try! link.outerHtml())
            let text = try! link.text()
            let range = ret.range(of: outerHtml)!
            ret.replaceSubrange(range, with: text)
        }

        for code in code.array() {
            ret = ret.replacingOccurrences(of: try! Entities.unescape(try! code.outerHtml()), with: try! code.text())
        }

        for italic in italics.array() {
            ret = ret.replacingOccurrences(of: try! italic.outerHtml(), with: try! italic.text())
        }

        let attrStr = NSMutableAttributedString(string: ret)

        for link in links.array() {
            let url = try! link.attr("href")
            let text = try! link.text()
            let range = ret.range(of: text)!
            let index: Int = ret.distance(from: ret.startIndex, to: range.lowerBound)
            attrStr.addAttribute(.link, value: url, range: NSRange(location: index, length: text.count))
        }

        guard let codeFont = UIFont(name: "Hack-Regular", size: 12) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }

        for code in code.array() {
            let text = try! code.text()
            let range = ret.range(of: text)!
            let index: Int = ret.distance(from: ret.startIndex, to: range.lowerBound)
            attrStr.addAttribute(.font, value: codeFont, range: NSRange(location: index, length: text.count))
        }

        for italic in italics.array() {
            let text = try! italic.text()
            let range = ret.range(of: text)!
            let index: Int = ret.distance(from: ret.startIndex, to: range.lowerBound)
            attrStr.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 12), range: NSRange(location: index, length: text.count))
        }


        return attrStr
    }

}
