//
//  createAccountViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class createAccountViewController: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var passwordVerif: UITextField!
    @IBOutlet weak var email: UITextField!
    
    let alertController = UIAlertController(title: "Erreur", message: "", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printResponse(response: Any) -> Bool {
        if let dict = response as? Dictionary<String, AnyObject> {
            print(dict)
            if (dict["success"] as! Bool) {
                BiketrackAPI.setToken(token: dict["token"] as! String)
                BiketrackAPI.setUserId(userId: dict["userId"] as! String)
                return true
            }
        }
        return false
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if (password.text! == "" || passwordVerif.text! == "" || email.text! == "") {
            alertController.message = "Champs incomplets"
            self.present(alertController, animated: true, completion: nil)
        }
        else if (password.text != passwordVerif.text!) {
            alertController.message = "Mot de passe différents"
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            _ = BiketrackAPI.signup(username: self.email.text!, password: self.password.text!)
                .flatMap { userCreated -> Observable<Any> in
                    return BiketrackAPI.login(username: self.email.text!, password: self.password.text!)
                }
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
}
