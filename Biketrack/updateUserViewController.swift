//
//  updateUserViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 03/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class updateUserViewController: UIViewController {
    private var _user: UserTest!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var updateProfilBtn: UIButton!
    
    var user: UserTest {
        get {
            return _user
        } set {
            _user = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                    if let dict = response as? Dictionary<String, AnyObject> {
                        print(self.user)
                        print(response)
                    }
                default:
                    print("default updateprofile")
                }
            })
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
