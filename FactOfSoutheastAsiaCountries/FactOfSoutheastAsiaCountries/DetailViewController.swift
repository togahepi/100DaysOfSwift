//
//  DetailViewController.swift
//  FactOfSoutheastAsiaCountries
//
//  Created by user197801 on 6/12/21.
//

import UIKit

class DetailViewController: UITableViewController {
    var detailItem : Country?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = detailItem?.countryName
        case 1:
            cell.textLabel?.text = "Main Language: \(detailItem!.language)"
        case 2:
            cell.textLabel?.text = "Capital: \(detailItem!.capital)"
        case 3:
            cell.textLabel?.text = "Area is: \(detailItem!.area) km2"
        case 4:
            cell.textLabel?.text = "Population is: \(detailItem!.population)"
        case 5:
            cell.textLabel?.text = "Official currency is: \(detailItem!.currency)"
        case 6:
            cell.textLabel?.text = "Calling code is: \(detailItem!.callingCode)"
        case 7:
            if let url = URL(string: detailItem!.flag) {
                if let data = try? Data(contentsOf: url) {
                    let flagImage = UIImage(data: data)
                    cell.imageView?.image = flagImage
                }
            }
            cell.textLabel?.text = "Official Flag"
            cell.textLabel?.textAlignment = .left
        default:
            return cell
        }
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
