//
//  ViewControllerTwo.swift
//  Google Books
//
//  Created by Zabeehullah Qayumi on 11/2/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit

struct ModelBook{
    var title : String = ""
    var details : String = ""
}



class ViewControllerTwo: UIViewController, sendFavorite {
  
    
    var favBooks = [ModelBook]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // adopting protocol
    func sendData(title: String, details: String) {
        favBooks.append(ModelBook(title: title, details: details))
    }

}


extension ViewControllerTwo : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favBooks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = favBooks[indexPath.row].title
        cell.detailTextLabel?.text = favBooks[indexPath.row].details
        
        return cell
    }
}
