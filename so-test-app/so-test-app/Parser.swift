//
//  Parser.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/10/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//

import Foundation

enum ParserError: Error, CustomStringConvertible {
    case MalformedData
    case NoData
    
    var description: String {
        switch self {
        case .MalformedData: return "The parser received malformed data."
        case .NoData: return "The parser resuled in no data."
        }
    }
}

struct Parser {
    
    func parseData(data: Data) throws -> [Question]? {
        
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonDict = json as? [String: AnyObject],
            let items = jsonDict["items"] as? [[String: AnyObject]],
            items.count > 0
        else {
                throw ParserError.MalformedData
        }
        
        guard items.count > 0 else { throw ParserError.NoData }
        
        var questions: [Question] = []
        
        let _ = items.map { (item) in
            if let q = Question(json: item) {
                questions.append(q)
            }
        }
        
        return questions
        
    }
    
}
