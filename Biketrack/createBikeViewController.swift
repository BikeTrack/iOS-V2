//
//  createBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 03/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class createBikeViewController: UIViewController {

    @IBOutlet weak var bikeName: UITextField!
    @IBOutlet weak var bikeBrand: UITextField!
    
    let alertController = UIAlertController(title: "Erreur", message: "", preferredStyle: UIAlertControllerStyle.alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        // Do any additional setup after loading the view.
    }

    @IBAction func addBikeBtn(_ sender: Any) {
        if (bikeName.text! == "") {
            alertController.message = "Le nom du vélo ne peut pas être vide"
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            _ = BiketrackAPI.createABike(name: bikeName.text!, brand: bikeBrand.text!)
                .subscribe({event in
                    switch event {
                    case .next(let response):
                        print(response)
                        self.performSegue(withIdentifier: "toBikeListVC", sender: nil)
                    default:
                        print("default createbike")
                    }
                }) 
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
