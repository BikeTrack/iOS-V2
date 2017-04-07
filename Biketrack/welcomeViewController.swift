//
//  welcomeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 15/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var LogoOnTop: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var bikes = [Bike]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let velo1 = Bike(image: "http://macadamcycles.com/3627-thickbox_default/extra-extrema-fixie-polish-columbus.jpg", title: "velo1", lat: 40.5, long: 68)
        let velo2 = Bike(image: "https://urban-fixie.com/media/catalog/product/cache/1/small_image/500x/21b2a4e09582ace586d8b86eff8f0f99/m/o/montage-aventon-mataro-low-blue-urban-fixie-.jpg", title: "velo2", lat: 40.5, long: 68)
        let velo3 = Bike(image: "http://i-cms.journaldunet.com/image_cms/original/1883975-le-fixie-un-velo-sans-freins-ni-derailleur-mais-qui-s-arrache.jpg", title: "velo3", lat: 40.5, long: 68)

        bikes.append(velo1)
        bikes.append(velo2)
        bikes.append(velo3)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogOutBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCell", for: indexPath) as? TableViewCell {
            let bike = bikes[indexPath.row]
            cell.updateUI(bike: bike)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBike = bikes[indexPath.row]
        performSegue(withIdentifier: "OneBike", sender: selectedBike)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneBikeViewController {
            if let oneBike = sender as? Bike {
                destination.bike = oneBike
            }
        }
    }
}
