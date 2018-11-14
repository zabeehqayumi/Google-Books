//
//  FavoriteViewModel.swift
//  GoogleBooks
//
//  Created by Zabeehullah Qayumi on 11/13/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import Foundation

//protocol FavoriteViewModelDelegate : class{
//    func 
//}

class FavoritesViewModel{
    
    var favorites = [String]()
    
    func fectchingDataFromUserDefautls(){
        
        let defaults = UserDefaults.standard
        if let favoritesDefaults = defaults.object(forKey: "favorites"){
            favorites = favoritesDefaults as? [String] ?? [""]
        }
    }
    
    func refreshingData(){
        favorites = []
        self.fectchingDataFromUserDefautls()

    }
    
    func deletingObjectsFromUserDefaults(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "favorites")
        defaults.synchronize()
        favorites.removeAll()
    }
    }

    
    

