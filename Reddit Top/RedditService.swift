//
//  RedditService.swift
//  Reddit Top
//
//  Created by jorge jesus mendoza balleza on 1/26/18.
//  Copyright © 2018 jorge jesus mendoza balleza. All rights reserved.
//

import Foundation

let redditEndPoint = "https://www.reddit.com/top/.json"

class RedditService {
    typealias JSONDictionary = [String: Any]
    typealias Result = ([Entry]?, String) -> ()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var entries: [Entry] = []
    var errorMessage = ""
    
    func getTopResults(limit: Int, completion: @escaping Result) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: redditEndPoint) {
            urlComponents.query = "limit=\(limit)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSearchResults(data)
                    DispatchQueue.main.async {
                        completion(self.entries, self.errorMessage)
                    }
                }
            }
            dataTask?.resume()
        }
    }
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        entries.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let responseData = response!["data"] as? JSONDictionary, let array = responseData["children"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        for entryDictionary in array {
            guard let entryDic = entryDictionary as? JSONDictionary, let entryData = entryDic["data"] as? JSONDictionary  else {
                continue
            }
            if  let title = entryData["title"] as? String,
                let author = entryData["author"] as? String,
                let dateDouble = entryData["created_utc"] as? Double,
                let comments = entryData["num_comments"] as? Int {
                let date = Date.init(timeIntervalSince1970: dateDouble)
                
                let entry = Entry(title: title, author: author, date: date, comments: comments)
                if let url = entryData["url"] as? String, let imageURL = URL(string:url){
                    entry.imageUrl = imageURL
                }
                if let thumbnailUrl = entryData["thumbnail"] as? String, let thumbnailImageURL = URL(string:thumbnailUrl){
                    entry.thumbnailUrl = thumbnailImageURL
                }
                entries.append(entry)
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
