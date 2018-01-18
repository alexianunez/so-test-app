//
//  Question.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/9/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//

import Foundation

struct Question {
    let id: Int
    let title: String
    let date: Date
    let answerCount: Int
    let score: Int
    let owner: Owner
}

struct Owner {
    let imageUrl: String
    let author: String
}

extension Question {
    
    // Since I've got an hour to do this, we'll be model just the necessary data to display onscreen. In a perfect world, I'd parse all the fields.
    
    private enum Keys: String {
        case id = "question_id"
        case title
        case score
        case answerCount = "answer_count"
        case date = "creation_date"
        case owner
    }
    
    init?(json: [String: AnyObject]) {
        guard
            let id = json[Keys.id.rawValue] as? Int,
            let answerCount = json[Keys.answerCount.rawValue] as? Int,
            let title = json[Keys.title.rawValue] as? String,
            let date = json[Keys.date.rawValue] as? TimeInterval,
            let score = json[Keys.score.rawValue] as? Int,
            let ownerInfo = json[Keys.owner.rawValue] as? [String: AnyObject],
            let owner = Owner(json: ownerInfo)
        else {
            return nil
        }
        self.id = id
        self.answerCount = answerCount
        self.title = title
        self.date = Date(timeIntervalSince1970: date)
        self.score = score
        self.owner = owner
    }
    
}

extension Owner {
    
    private enum Keys: String {
        case imageUrl = "profile_image"
        case author = "display_name"
    }
    
    init?(json: [String: AnyObject]) {
        guard
        let author = json[Keys.author.rawValue] as? String,
        let imageUrl = json[Keys.imageUrl.rawValue] as? String
            else {
                return nil
        }
        self.author = author
        self.imageUrl = imageUrl
    }
    
}
