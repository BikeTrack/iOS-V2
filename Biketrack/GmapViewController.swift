//
//  GmapViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 07/04/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
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
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(bike.lat), longitude: CLLocationDegrees(bike.long), zoom: 5)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
