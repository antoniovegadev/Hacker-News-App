//
//  Item.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import Foundation

struct Item: Codable {
    /// The item's unique id.
    let id: ID
    /// true if the item is deleted.
    let deleted: Bool?
    /// The type of item. One of "job", "story", "comment", "poll", or "pollopt".
    let type: String
    /// the username of the item's author
    let author: String
    /// creation date of the item, in Unix time
    let dateCreated: Date
    /// The comment, story or poll text.
    let text: HTML?
    /// true if the item is dead.
    let dead: Bool?
    /// The comment's parent: either another comment or the relevant story.
    let parent: Int?
    /// The pollopt's associated poll.
    let poll: Int?
    /// The ids of the item's comments, in ranked display order.
    let kids: [ID]?
    /// The URL of the story.
    let urlString: String?
    /// The story's score, or the votes for a pollopt.
    let score: Int?
    /// The title of the story, poll or job. HTML.
    let title: String?
    /// A list of related pollopts, in display order.
    let parts: [Int]?
    /// the total comment count
    let commentCount: Int?

    var rank = -1
}

extension Item {
    enum CodingKeys: String, CodingKey {
        case id
        case deleted
        case type
        case author = "by"
        case dateCreated = "time"
        case text
        case dead
        case parent
        case poll
        case kids
        case urlString = "url"
        case score
        case title
        case parts
        case commentCount = "descendants"
    }
}

extension Item {
    var wrappedDead: Bool { dead ?? false }
    var wrappedDeleted: Bool { deleted ?? false }
    var wrappedCommentCount: Int { commentCount ?? 0 }
}
