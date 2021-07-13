//
//  ViewController.swift
//  Project18
//
//  Created by user197801 on 6/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(1,2,3,4,5,6)
        print("Love u", terminator: "<3")
        print(5,4,3,2,1, separator: "&")
        
        assert(1==1, "oh no oh no oh no")
        
        for i in 1...100 {
            print("I love \(i)")
        }
    }


}

