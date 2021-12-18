//
//  Item.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import Foundation

typealias ID = Int

struct Item: Codable {
    let id: ID
    let deleted: Bool?
    let type: String
    let by: String
    let time: Date
    let text: String?
    let dead: Bool?
    let parent: Int?
    let poll: Int?
    let kids: [Int]?
    let url: String?
    let score: Int?
    let title: String?
    let parts: [Int]?
    let descendants: Int?

    var rank = -1

    var wrappedDead: Bool { dead ?? false }
    var wrappedDeleted: Bool { deleted ?? false }
    var wrappedDescendants: Int { descendants ?? 0 }

    enum CodingKeys: CodingKey {
        case id
        case deleted
        case type
        case by
        case time
        case text
        case dead
        case parent
        case poll
        case kids
        case url
        case score
        case title
        case parts
        case descendants
    }
}
