//
//  DetailViewController.swift
//  Project1WithCollectViewController
//
//  Created by user197801 on 5/30/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedImage.replacingOccurrences(of: "nssl00", with: "Picture ")
        imageView.image = UIImage(named: selectedImage)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
