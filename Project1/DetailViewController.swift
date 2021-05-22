//
//  DetailViewController.swift
//  Project1
//
//  Created by user197801 on 5/7/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageNumber = 0
    var totalPicture = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(selectedImageNumber) of \(totalPicture)"
        navigationItem.largeTitleDisplayMode = .never
        if let imagetoLoad = selectedImage {
            imageView.image = UIImage(named: imagetoLoad)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
