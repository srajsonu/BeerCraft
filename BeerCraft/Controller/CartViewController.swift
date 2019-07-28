//
//  CartViewController.swift
//  BeerCraft
//
//  Created by ARY@N on 28/07/19.
//

import UIKit

class CartViewController: UIViewController,cart {
    func item(title: String) {
        self.items = title
    }
    
    let beerDelegate = BeerViewController()
    
    @IBOutlet weak var tableView: UITableView!
    var items = "2"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        beerDelegate.delegate = self
    }
    
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        //cell.titleView.text = items
        cell.quantity.text = items
        return cell
    }
}
