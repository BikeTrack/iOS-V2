//
//  updateUserViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 03/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class updateUserViewController: UIViewController, UITextFieldDelegate {
    private var _user: User!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var updateProfilBtn: UIButton!
    
    var user: User {
        get {
            return _user
        } set {
            _user = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        emailField.text = user.mail
        firstNameField.text = user.name
        lastNameField.text = user.lastname
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateProfil(_ sender: Any) {
        BiketrackAPI.updateUser(email: emailField.text!, name: firstNameField.text!, lastname: lastNameField.text!)
            .subscribe({ event in
                switch event {
                case .next(let response):
                    self.performSegue(withIdentifier: "toProfilVC", sender: nil)
                    
                default:
                    print("default updateprofile")
                }
            })
    }
}
