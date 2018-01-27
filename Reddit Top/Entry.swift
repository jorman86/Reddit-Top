//
//  Entry.swift
//  Reddit Top
//
//  Created by jorge jesus mendoza balleza on 1/26/18.
//  Copyright © 2018 jorge jesus mendoza balleza. All rights reserved.
//

import Foundation
import UIKit

protocol EntryDelegate : class{
    func imageReady(image:UIImage?)
}

class Entry{
    var title : String
    var author : String
    var date : Date
    var thumbnailImage : UIImage?
    var thumbnailUrl : URL?{
        didSet{
            DispatchQueue.main.async {
                if let thumb = self.thumbnailUrl, UIApplication.shared.canOpenURL(thumb){
                    self.downloadThumbnail(url: thumb)
                } else {
                    self.thumbnailImage = #imageLiteral(resourceName: "NoImage")
                }
            }
        }
    }
    var imageUrl : URL?
    var comments : Int
    weak var delegate : EntryDelegate?
    
    init(title:String, author:String, date:Date, comments:Int) {
        self.title = title
        self.author = author
        self.date = date
        self.comments = comments
    }
    public var description: String {
        return """
        Entry
        Title: \(self.title)
        Author: \(self.author)
        Date: \(self.date)
        Comments: \(self.comments)
        """
    }
    
    func downloadThumbnail(url:URL){
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                    if let delegate = self.delegate{
                        delegate.imageReady(image: nil)
                    }
                    return
                }
                self.thumbnailImage = UIImage(data:data!)
                
                //update cells
                if let delegate = self.delegate{
                    delegate.imageReady(image: self.thumbnailImage)
                }
            }
        }).resume()
    }
}
