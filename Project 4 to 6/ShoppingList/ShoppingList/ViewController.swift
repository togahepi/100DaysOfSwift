//
//  ViewController.swift
//  ShoppingList
//
//  Created by user197801 on 5/19/21.
//

import UIKit

class ViewController: UITableViewController {
    var listToShop = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list for mom!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToBuy))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItemToBuy))
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearItem))
        navigationItem.leftBarButtonItems = [share,clear]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listToShop.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopList", for: indexPath)
        cell.textLabel?.text = listToShop[indexPath.row]
        return cell
    }
    
    @objc func clearItem() {
        listToShop.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addItemToBuy() {
        let ac = UIAlertController(title: "Mom's new order", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let shopItem = ac?.textFields?[0].text else {return}
            self?.add(shopItem)
        }
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    func add(_ shopItem: String) {
        let lowerShopItem = shopItem.lowercased()
        listToShop.insert(lowerShopItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func shareItemToBuy() {
        let list = listToShop.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        present(vc, animated: true)
    }

}

