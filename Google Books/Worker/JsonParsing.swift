//
//  JsonParsing.swift
//  GoogleBooks
//
//  Created by Zabeehullah Qayumi on 11/13/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import Foundation
import SwiftyJSON



final class JsonParsing{
        
    static func jsonFile(_ booksName : String, onSuccess : @escaping ([[String:AnyObject]]) ->()){
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(booksName)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            
            do{

                let json = try JSON(data: data)
                if let items = json["items"].arrayObject as? [[String:AnyObject]]{
                    onSuccess(items)
                }
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    
    
    
}
