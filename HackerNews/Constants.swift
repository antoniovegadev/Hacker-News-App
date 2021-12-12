//
//  Constants.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import UIKit

enum LiveData: String {
    case topstories
    case beststories
    case newstories
    case askstories
    case showstories
    case jobstories

    static let topStoriesSFSymbol = UIImage(systemName: "crown")
    static let bestStoriesSFSymbol = UIImage(systemName: "star")
    static let newStoriesSFSymbol = UIImage(systemName: "clock")
    static let askStoriesSFSymbol = UIImage(systemName: "music.mic")
    static let showStoriesSFSymbol = UIImage(systemName: "eyes")
    static let jobStoriesSFSymbol = UIImage(systemName: "briefcase")
}
