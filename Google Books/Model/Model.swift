//
//  Model.swift
//  GoogleBooks
//
//  Created by Zabeehullah Qayumi on 11/13/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

// this line is for testing purpose 

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
