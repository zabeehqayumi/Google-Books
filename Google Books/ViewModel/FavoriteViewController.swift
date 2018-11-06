//
//  ViewControllerTwo.swift
//  Google Books
//
//  Created by Zabeehullah Qayumi on 11/2/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit


class FavoriteViewController: UIViewController {
    
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
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        self.tableView.reloadData()

    }
    
    @IBAction func deleteButtonPresed(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "favorites")
        defaults.synchronize()
        self.tableView.reloadData()
    }
}


extension FavoriteViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = favorites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.favorites.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        
        
    }
    
    
}
