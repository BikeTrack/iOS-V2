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

    private var _bike: Bike!
    
    var bike: Bike {
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
                    var lastCoordinates = response.locations.last?.coordinates
                    let camera = GMSCameraPosition.camera(withLatitude: (lastCoordinates![1]), longitude: (lastCoordinates![0]), zoom: 15)
                    let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
                    var i = 0
                    for location in response.locations {
                        let new_marker = GMSMarker()
                        if ((location.coordinates) != nil) {
                            new_marker.position = CLLocationCoordinate2D(latitude: (location.coordinates![1]), longitude: (location.coordinates![0]))
                            if (i == response.locations.count - 1) {
                                new_marker.icon = GMSMarker.markerImage(with: .blue)
                            }
                            new_marker.map = mapView
                        } else {
                            print("erreur coordinates")
                        }
                        i += 1
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
