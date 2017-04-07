//
//  createAccountViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 15/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Moya
import UIKit
import RxCocoa
import RxSwift

class createAccountViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordVerif: UITextField!
    @IBOutlet weak var putainDeRxButton: UIButton!
    
    var biketrackApi = BiketrackAPI()
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
    
    @IBAction func BackBtnPressed(_ sender: AnyObject) {
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
        _ = putainDeRxButton.rx.tap
            .flatMap({
                return self.biketrackApi.signup(username: self.username.text!, password: self.password.text!)
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
    
//    @IBAction func createAccountPushed(_ sender: AnyObject) {
//        print(password!)
//        print(passwordVerif!)
//        if (!(password.text! == passwordVerif.text!)) {
//            alertController.message = "The two password are different"
//            self.present(self.alertController, animated: true, completion: nil)
//            return
//        }
//        biketrackApi.createAccount(username: username.text!, password: password.text!) { (userCreation) -> () in
//            if (userCreation) {
//                self.performSegue(withIdentifier: "accountCreated", sender: nil)
//            }
//            else {
//                self.alertController.message = "Bad format for create an account"
//                self.present(self.alertController, animated: true, completion: nil)
//            }
//        }
//    }
}
