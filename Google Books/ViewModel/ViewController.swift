//
//  ViewController.swift
//  Google Books
//
//  Created by Zabeehullah Qayumi on 11/2/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController {
    
    var books1 = [[String:AnyObject]]()
    
    
    
    
    var globalTitle : String = ""
    var globalDetails : String = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var arrOfBooks = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        JsonParsing.jsonFile("") {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let volumeInfo = self.books1[indexPath.row]["volumeInfo"] as? [String:AnyObject]{
            cell.textLabel?.text = volumeInfo["title"] as? String
            cell.detailTextLabel?.text = volumeInfo["subtitle"] as? String
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)


        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark

        }

    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, indexPath) in
            var favorites : [String] = []
            let defaults = UserDefaults.standard
            if let favoritesDefaults = defaults.object(forKey: "favorites"){
                favorites = favoritesDefaults as! [String]
            }
            

            favorites.append(tableView.cellForRow(at: indexPath)?.textLabel!.text ?? "")
            defaults.set(favorites, forKey: "favorites")
            defaults.synchronize()
        }
        return [favorite]

        
    }
    
    
}



extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let bookTitle = searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        JsonParsing.jsonFile(bookTitle, onSuccess: { [weak self] book in
            self?.books1 = book
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } )
        //self.jsonFile(bookTitle)
        searchBar.resignFirstResponder()
    }
}


