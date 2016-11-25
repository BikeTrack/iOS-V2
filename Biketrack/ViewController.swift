//
//  ViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 13/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var biketrackApi = BiketrackAPI()
    let alertController = UIAlertController(title: "login", message: "", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPushLogin(_ sender: UIButton) {
        biketrackApi.login(username: self.email.text!, password: self.password.text!) {
            (loginSuccess) -> () in
            if (loginSuccess) {
                print("success")
                self.performSegue(withIdentifier: "loginToWelcome", sender: nil)
            } else {
                self.alertController.message = "log in failed"
            }
            self.present(self.alertController, animated: true, completion: nil)
        }
    }
}

