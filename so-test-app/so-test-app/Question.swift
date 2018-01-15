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
}

extension Question {
    
    // Since I've got an hour to do this, we'll be model just the necessary data to display onscreen. In a perfect world, I'd parse all the fields.
    
    private enum Keys: String {
        case id = "question_id"
        case title
        case score
        case answerCount = "answer_count"
        case date = "creation_date"
    }
    
    init?(json: [String: AnyObject]) {
        guard
            let id = json[Keys.id.rawValue] as? Int,
            let answerCount = json[Keys.answerCount.rawValue] as? Int,
            let title = json[Keys.title.rawValue] as? String,
            let date = json[Keys.date.rawValue] as? TimeInterval,
            let score = json[Keys.score.rawValue] as? Int
        else {
            return nil
        }
        self.id = id
        self.answerCount = answerCount
        self.title = title
        self.date = Date(timeIntervalSince1970: date)
        self.score = score
    }
    
}
