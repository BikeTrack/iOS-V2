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
        let newBike = Bike(title: bikeName.text!)
        performSegue(withIdentifier: "NewBike", sender: newBike)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? welcomeViewController {
            if let bike = sender as? Bike {
                destination.bikes.append(bike)
            }
        }
    }
}
