//
//  GmapViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit
import GoogleMaps

class GmapViewController: UIViewController {

    private var _bike: BikeTest!
    
    var bike: BikeTest {
        get {
            return _bike
        } set {
            _bike = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupRx() {
        _ = BiketrackAPI.getLocations()
            .subscribe({ event in
                switch event {
                case .next(let response):
                    print(response)
                    let camera = GMSCameraPosition.camera(withLatitude: (response.locations.last?.coordinates[1])!, longitude: (response.locations.last?.coordinates[0])!, zoom: 15)
                    let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
                    for location in response.locations {
                        let new_marker = GMSMarker()
                        new_marker.position = CLLocationCoordinate2D(latitude: location.coordinates[1], longitude: location.coordinates[0])
                        new_marker.map = mapView
                        
                    }
                    self.view = mapView
                default:
                    print("default get location")
                }
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
