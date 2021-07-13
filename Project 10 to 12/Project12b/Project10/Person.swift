//
//  Person.swift
//  Project10
//
//  Created by user197801 on 5/30/21.
//

import UIKit

class Person: NSObject, Codable {
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    var name: String
    var image: String
}
