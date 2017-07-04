//
//  CreateBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 06/04/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
//

import UIKit

class CreateBikeViewController: UIViewController {

    @IBOutlet weak var bikeName: UITextField!
    @IBOutlet weak var bikeColor: UITextField!
    @IBOutlet weak var bikeBrand: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToWelcome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newBike(_ sender: Any) {
        BiketrackAPI.createABike(name: bikeName.text!, color: bikeColor.text!, brand: bikeBrand.text!)
        .subscribe{ event in
            switch event {
                case .next(let response):
                    print(response)
                case .error(let error):
                    print(error)
                default:
                    print("default")
            }
        }
        performSegue(withIdentifier: "NewBike", sender: nil)
    }
    
}
