//
//  Model.swift
//  Google Books
//
//  Created by Zabeehullah Qayumi on 11/2/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Model{
    
    var thumbnail : String = ""
    var title : String = ""
    var author : String = ""
    
    init() {
    }
    
    init(json : JSON) {
        thumbnail = json["thumbnail"].stringValue
        title = json["title"].stringValue
        author = json["author"].stringValue
    }
    
    
}
