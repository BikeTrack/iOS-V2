//
//  createAccountViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class createAccountViewController: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var passwordVerif: UITextField!
    @IBOutlet weak var email: UITextField!
    
    let alertController = UIAlertController(title: "CreateAccount", message: "", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func printResponse(response: Any) -> Bool {
        if let dict = response as? Dictionary<String, AnyObject> {
            print(dict)
            return (dict["success"] as! Bool)
        }
        return false
    }
    
    func setupRx() {
        _ = createAccountBtn.rx.tap
            .flatMap({
                return BiketrackAPI.signup(username: self.email.text!, password: self.password.text!)
            })
            .subscribe({ event in
                switch event {
                case let .next(response):
                    self.printResponse(response: response) ? self.performSegue(withIdentifier: "accountCreated", sender: nil) : print("error")
                default:
                    print("error")
                }
            })
    }

}
