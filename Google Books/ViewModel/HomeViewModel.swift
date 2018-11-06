//
//  HomeViewModel.swift
//  GoogleBooks
//
//  Created by Zabeehullah Qayumi on 11/6/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import Foundation


protocol HomeViewModelDelegate : class {
    func booksUpdated()
}

class HomeViewModel{
    
    weak var delegate: HomeViewModelDelegate?
    var books = [[String:AnyObject]]()
    var searchText : String = ""
    func search(for text : String){
        
        JsonParsing.jsonFile(text, onSuccess: { [weak self] books in
            self?.books = books
            self?.delegate?.booksUpdated()
        
        })
    }
    
    func addFavorite(_ book: String){
        var favorites : [String] = []
        let defaults = UserDefaults.standard
        if let favoritesDefaults = defaults.object(forKey: "favorites"){
            favorites = favoritesDefaults as! [String]
        }
        
        favorites.append(book)
        defaults.set(favorites, forKey: "favorites")
        defaults.synchronize()
    }
}
