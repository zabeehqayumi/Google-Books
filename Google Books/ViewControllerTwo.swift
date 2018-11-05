//
//  ViewControllerTwo.swift
//  Google Books
//
//  Created by Zabeehullah Qayumi on 11/2/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit


class ViewControllerTwo: UIViewController {
    
    
    var favorites : [String] = []
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let favoritesDefaults = defaults.object(forKey: "favorites"){
            favorites = favoritesDefaults as? [String] ?? [""]
        }
        
        self.tableView.reloadData()

    }
    
}


extension ViewControllerTwo : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
       // cell.textLabel?.text = favBooks[indexPath.row].title
        cell.textLabel?.text = favorites[indexPath.row]
        
        return cell
    }
    
    
}
