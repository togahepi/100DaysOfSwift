//
//  ViewController.swift
//  Project4
//
//  Created by user197801 on 5/11/21.
//

import UIKit
import WebKit

class ViewController: UITableViewController {
    var websites = ["hackingwithswift.com", "genk.vn", "apple.com", "google.com", "dantri.com.vn"]
    var totalRow = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basic Web Browser"
        totalRow = websites.count
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalRow
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Websites", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedWebsite = websites[indexPath.row]
            vc.websites = websites
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



