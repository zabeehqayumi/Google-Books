//
//  FavoriteViewController.swift
//  GoogleBooks
//
//  Created by Zabeehullah Qayumi on 11/13/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit


class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel = FavoritesViewModel()

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fectchingDataFromUserDefautls()
        self.tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
    viewModel.refreshingData()
        self.tableView.reloadData()
        
    }
    
    @IBAction func deleteButtonPresed(_ sender: Any) {
        viewModel.deletingObjectsFromUserDefaults()
        self.tableView.reloadData()
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = viewModel.favorites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.viewModel.favorites.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





