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

class ViewController: UIViewController {

 
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Map"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        }
    }
}

