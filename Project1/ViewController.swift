//
//  ViewController.swift
//  Project1
//
//  Created by user197801 on 5/6/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var totalRow = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"          //this change title of each screen
        navigationController?.navigationBar.prefersLargeTitles = true       //large Title for first screen
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        print(items)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        totalRow = pictures.count
        pictures.sort()
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {      //this methods sets how many rows will appear in our table view
        //return pictures.count
        return totalRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(totalRow) and section is: \(indexPath.section)"
        //cell.textLabel?.text = "Click here magic will happen"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //try to load view controller with storyboard id "Detail" and typecasting it to DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //set value for selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            //set index for selected image
            vc.selectedImageNumber = indexPath.row + 1
            vc.totalPicture = totalRow
            //push view controller to navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

