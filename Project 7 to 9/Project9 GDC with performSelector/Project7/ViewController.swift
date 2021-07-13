//
//  ViewController.swift
//  Project7
//
//  Created by user197801 on 5/20/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var petitionsFilter = [Petition]()
    var filter = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "About", style: .done,target: self, action: #selector(showInfo))
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filterPetition))
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        
        navigationItem.leftBarButtonItems = [filterButton,refreshButton]
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        var urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                print(data)
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showError() {
        let vc = UIAlertController(title: "Error while fetching data!", message: "Please check you internet connection!", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK brooo!", style: .cancel))
        present(vc, animated: true)
    }
    
    @objc func refreshData() {
        filter = false
        petitionsFilter.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func filterPetition() {
        let ac = UIAlertController(title: "Enter keyword", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Filter", style: .default) { [weak ac, weak self] _ in
            guard let keyword = ac?.textFields?[0].text else {return}
            self?.filter(for: keyword)
        }
        
        ac.addAction(action)
        
        present(ac, animated: true)
    }
    
    func filter(for keyword: String) {
        filter = true
        let lowerKeyword = keyword.lowercased()
        for petition in petitions {
            let lowerPetitionTitle = petition.title.lowercased()
            let lowerPetitionBody = petition.body.lowercased()
            if lowerPetitionTitle.contains(lowerKeyword) || lowerPetitionBody.contains(lowerKeyword) {
                petitionsFilter.append(petition)
            }
        }
        print(petitionsFilter)
        tableView.reloadData()
    }
    
    @objc func showInfo() {
        let ac = UIAlertController(title: "Source of data", message: "We The People API of the White House", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filter {
            return petitionsFilter.count
        }
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if filter {
            let petition = petitionsFilter[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        } else {
            let petition = petitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if filter {
            vc.detailItem = petitionsFilter[indexPath.row]
        } else {
            vc.detailItem = petitions[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}

