//
//  ViewController.swift
//  Project12
//
//  Created by user197801 on 6/2/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        defaults.set(30, forKey: "Age")
        defaults.set("Virgin", forKey: "Have Sex?")
        defaults.set(true, forKey: "UserFaceID")
        defaults.set(CGFloat.pi, forKey: "pi")
        
        let array = ["Hello", "Sweet", "Girl"]
        defaults.set(array,forKey: "Love you")
        
        let dict = ["name": "Hepi", "Country": "VN"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        let savedInterger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UserFaceID")
        
        let savedArray = defaults.object(forKey: "Love you") as? [String] ?? [String]()
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
        
        
    }


}

