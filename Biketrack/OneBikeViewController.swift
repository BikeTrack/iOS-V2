//
//  OneBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class OneBikeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bikeImg: UIImageView!
    @IBOutlet weak var batteryImg: UIImageView!
    @IBOutlet weak var bikeTitle: UILabel!
    private var _bike: Bike!
    let menuManager = MenuManager()
    
    var bike: Bike {
        get {
            return _bike
        } set {
            _bike = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch bike.batteryPercentage {
        case 0...10:
            batteryImg.image = UIImage(named: "002-empty-battery")
        case 10...30:
            batteryImg.image = UIImage(named: "001-battery")
        default:
            batteryImg.image = UIImage(named: "003-technology")
        }
        bikeTitle.text = bike.name
        menuManager.items = [(NSLocalizedString("Modify the bike", comment: "modifybike"), self.updateBike),
                             (NSLocalizedString("Delete the bike", comment: "deleteBike"), self.deleteBike)]
        //        let url = URL(string: bike.image)!
        
        //        DispatchQueue.global().async {
        //            do {
        //                let data = try Data(contentsOf: url)
        //                DispatchQueue.main.async {
        //                    self.bikeImg.image = UIImage(data: data)
        //                }
        //            } catch {
        //                // handle the error
        //            }
        //        }
        // Do any additional setup after loading the view.
    }
    
    func updateBike() {
        performSegue(withIdentifier: "toUpdateVC", sender: bike)
    }
    
    func deleteBike() {
        print(bike)
        BiketrackAPI.deleteBike(bikeId: bike.id)
            .subscribe{ event in
                switch event {
                case .next(let response):
                    self.menuManager.dissmissMenu()
                    self.performSegue(withIdentifier: "toFirstVC", sender: nil)
                default:
                    print("default motherfucker")
                }
            }
    }
    
    @IBAction func moreOption(_ sender: Any) {
        menuManager.openMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GmapViewController {
            destination.bike = bike
        }
        
        if let destination = segue.destination as? updateBikeViewController {
            destination.bike = bike
        }
    }
}
