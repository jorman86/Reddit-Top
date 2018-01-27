//
//  Entry.swift
//  Reddit Top
//
//  Created by jorge jesus mendoza balleza on 1/26/18.
//  Copyright © 2018 jorge jesus mendoza balleza. All rights reserved.
//

import Foundation
import UIKit

class Entry{
    var title : String
    var author : String
    var date : Date
    var thumbnailImage : UIImage?
    var thumbnailUrl : URL?
    var imageUrl : URL?
    var comments : Int
    
    init(title:String, author:String, date:Date, comments:Int) {
        self.title = title
        self.author = author
        self.date = date
        self.comments = comments
    }
}
