//
//  ViewController.swift
//  FactOfSoutheastAsiaCountries
//
//  Created by user197801 on 6/12/21.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Southest Asia Countries Facts"
        if let dataUrl = Bundle.main.url(forResource: "facts", withExtension: "json") {
            print(dataUrl)
            if let data = try? Data(contentsOf: dataUrl) {
                print(data)
                let decoder = JSONDecoder()
                if let jsonCountries = try? decoder.decode(Countries.self, from: data) {
                    countries = jsonCountries.facts
                    tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].countryName
        if let url = URL(string: countries[indexPath.row].flag) {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                cell.imageView!.image = image
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            vc.detailItem = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}

