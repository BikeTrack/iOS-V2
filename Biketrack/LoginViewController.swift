//
//  LoginViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var logIn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
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
    
    func setupRx() {
        _ = logIn.rx.tap
            .flatMap({return BiketrackAPI.login(username: self.email.text!, password: self.password.text!)})
            .subscribe({ event in
                switch event {
                case let .next(response):
                    self.printResponse(response: response) ? self.performSegue(withIdentifier: "toTBC", sender: nil) : print("error")
                default:
                    print("defaut")
                }
            })
    }
}
