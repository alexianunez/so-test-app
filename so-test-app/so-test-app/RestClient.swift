//
//  RestClient.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/9/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//
import Foundation

typealias RestResponse = ([Question]?, Error?)

enum RestClientError: Error, CustomStringConvertible {
    case InvalidURL
    case UnknownError
    case APIError(Error)
    case NoData
    
    var description: String {
        switch self {
            case .InvalidURL: return "The request URL used was invalid"
            case .UnknownError: return "Unknown Error"
            case .NoData: return "The request returned no data."
            case .APIError(let msg): return "\(msg)"
        }
    }
}

struct RestClient {
    
    fileprivate let parser: Parser = Parser()
    
    func fetchData(urlString: String, completion: @escaping (RestResponse) -> ()) -> Void {
        
        guard let url: URL = self.urlForString(urlString: urlString) else {
            completion((nil, RestClientError.InvalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
        if let unwrappedError = error, let unwrappedResponse = response as? HTTPURLResponse, unwrappedResponse.statusCode != 200 {
                completion((nil, RestClientError.APIError(unwrappedError)))
                return
            }
            
        guard
            let unwrappedData = data, let questions = try? self.parser.parseData(data: unwrappedData) else {
                completion((nil, RestClientError.NoData))
                return
            }
        
            completion((questions, nil))
        }
        task.resume()
        
    }
    
    private func urlForString(urlString: String) -> URL? {
        return URL(string: urlString)
    }
}

