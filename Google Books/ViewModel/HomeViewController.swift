//
//  ViewController.swift
//  Google Books
//
//  Created by Zabeehullah Qayumi on 11/2/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import SwiftyJSON


class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}


extension HomeViewController: HomeViewModelDelegate {
    
    func booksUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let volumeInfo = self.viewModel.books[indexPath.row]["volumeInfo"] as? [String:AnyObject]{
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
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, indexPath) in
            let book = tableView.cellForRow(at: indexPath)?.textLabel!.text ?? ""
            self.viewModel.addFavorite(book)

        }
        return [favorite]
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{return}

        viewModel.search(for: text)
        searchBar.resignFirstResponder()
    }
}


