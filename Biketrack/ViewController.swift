//
//  ViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 13/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Moya
import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rxButton: UIButton!
    
    let alertController = UIAlertController(title: "login", message: "", preferredStyle: UIAlertControllerStyle.alert)
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
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
        _ = rxButton.rx.tap
        .flatMap({return BiketrackAPI.login(username: self.email.text!, password: self.password.text!)})
        .subscribe({ event in
            switch event {
                case let .next(response):
                    self.printResponse(response: response) ? self.performSegue(withIdentifier: "loginToWelcome", sender: nil) : print("error")
                default:
                    print("defaut")
            }
        })
    }
}

