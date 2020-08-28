//
//  ViewController.swift
//  GetDirection
//
//  Created by Abdul Sami Sultan on 28/08/2020.
//  Copyright © 2020 Sami. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

 
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Map"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor  = .lightGray
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        
        mapView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func getDirectionTapped(_ sender: Any) {
        getAddress()
    }
    func getAddress(){
        print(textField.text!)
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textField.text!) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else{
                return
            }
            
            
            
            print(location)
            self.mapThis(destinationCord: location.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    func mapThis(destinationCord: CLLocationCoordinate2D){
        let sourceCordinate = (locationManager.location?.coordinate)!
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else{
                if let error = error{
                    print(error)
                }
                return
            }
            let routes = response.routes[0]
            self.mapView.addOverlay(routes.polyline)
            self.mapView.setVisibleMapRect(routes.polyline.boundingMapRect, animated: true)
            
        }
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}

