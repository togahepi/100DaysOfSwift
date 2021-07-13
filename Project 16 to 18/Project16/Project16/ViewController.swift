//
//  ViewController.swift
//  Project16
//
//  Created by user197801 on 6/12/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        mapView.delegate = self     //this line is very important :))

        super.viewDidLoad()
        
        let btn = UIBarButtonItem(title: "Map Style", style: .done, target: self, action: #selector(selectMapStyle))
        navigationItem.leftBarButtonItem = btn
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Very beautiful city! <3", wikiPage: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Lovely city like a girl", wikiPage: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "City of sexy lady", wikiPage: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Contain a whole country in it!", wikiPage: "https://en.wikipedia.org/wiki/Rome")
        let hanoi = Capital(title: "Hanoi", coordinate: CLLocationCoordinate2D(latitude: 21.03, longitude: 105.83), info: "A thousand year old city!",wikiPage: "https://en.wikipedia.org/wiki/Hanoi")
        mapView.addAnnotations([london,oslo,paris,rome,hanoi])

    }
    
    @objc func selectMapStyle() {
        let ac = UIAlertController(title: "Select map type:", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Satelite", style: .default) { [weak self] _ in
            self?.mapView.mapType = .satellite
        })
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.mapView.mapType = .hybrid
        })
        ac.addAction(UIAlertAction(title: "Standard", style: .default) { [weak self] _ in
            self?.mapView.mapType = .standard
        })
        ac.addAction(UIAlertAction(title: "Mute Standard", style: .default) { [weak self] _ in
            self?.mapView.mapType = .mutedStandard
        })
        ac.addAction(UIAlertAction(title: "Hybrid fly over", style: .default) { [weak self] _ in
            self?.mapView.mapType = .hybridFlyover
        })
        ac.addAction(UIAlertAction(title: "Satelite fly over", style: .default) { [weak self] _ in
            self?.mapView.mapType = .satelliteFlyover
        })
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(ac, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {
            return nil
        }
        
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            annotationView?.annotation  = annotation
        }
        
        annotationView?.pinTintColor = .green
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {
            return
        }
//         Display quick alert action about annotation
//        let placeName = capital.title
//        let placeInfo = capital.info
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
        if let view = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            view.cityWikiPage = capital.wikiPage
            
            navigationController?.pushViewController(view, animated: true)
        }
        
        
    }


}

 
