//
//  Person.swift
//  Project10
//
//  Created by user197801 on 5/30/21.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    func encode(with acoder: NSCoder) {
        acoder.encode(name, forKey: "name")
        acoder.encode(image, forKey: "image")
    }
    
}
