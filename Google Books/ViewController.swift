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
    
    var books = [[String:AnyObject]]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var arrOfBooks = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func jsonFile(_ booksName : String){
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(booksName)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let items = json["items"].arrayObject as! [[String:AnyObject]]
                self.books.append(contentsOf: items)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? [String:AnyObject]{
            cell.textLabel?.text = volumeInfo["title"] as? String
            cell.detailTextLabel?.text = volumeInfo["subtitle"] as? String
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none

        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark

        }
    }
}



extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let bookTitle = searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        self.jsonFile(bookTitle)
        searchBar.resignFirstResponder()
    }
}
