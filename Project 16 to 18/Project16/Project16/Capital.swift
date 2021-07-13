//
//  Capital.swift
//  Project16
//
//  Created by user197801 on 6/12/21.
//
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikiPage: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikiPage: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikiPage = wikiPage
    }
    
}
