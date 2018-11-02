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
    
    @IBOutlet weak var tableView: UITableView!
    var arrOfBooks = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        jsonFile("harrypotter")
    }
    
    //https://www.googleapis.com/books/v1/volumes?q=harrypotter
    
    func jsonFile(_ booksName : String){
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(booksName)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            
            do{
                let json = try JSON(data: data)
                print(json)
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    
}

