//
//  ViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 13/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Moya
import Moya_ModelMapper
import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rxButton: UIButton!
    
    var biketrackApi = BiketrackAPI()
    let alertController = UIAlertController(title: "login", message: "", preferredStyle: UIAlertControllerStyle.alert)
    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<BikeTrackTestRx> = RxMoyaProvider<BikeTrackTestRx>()
    
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
            if (dict["error"] != nil) {
                return false
            }
        }
        return true
    }
    
    func setupRx() {
        _ = rxButton.rx.tap
        .flatMap({return self.biketrackApi.login(username: self.email.text!, password: self.password.text!)})
        .subscribe({ event in
            switch event {
                case let .next(response):
                    self.printResponse(response: response) ? self.performSegue(withIdentifier: "loginToWelcome", sender: nil) : print("error")
                default:
                    print("defaut")
            }
        })
    }
    
//    @IBAction func onPushLogin(_ sender: UIButton) {
//        biketrackApi.login(username: self.email.text!, password: self.password.text!) {
//            (loginSuccess) -> () in
//            if (loginSuccess) {
//                print("success")
//                self.performSegue(withIdentifier: "loginToWelcome", sender: nil)
//            } else {
//                self.alertController.message = "log in failed"
//            }
//            self.present(self.alertController, animated: true, completion: nil)
//        }
//    }
//    
//    func checkTextField() {
//        let validEmailObservable = emailTextField.rx.text.map { email in
//            email!.characters.count > 5
//            }.distinctUntilChanged()
//        let validPasswordObservable = passwordTextField.rx.text.map { password in
//            (password?.isEmpty)! ? UIColor.green : UIColor.white
//            }.distinctUntilChanged()
//        
//        _ = validEmailObservable
//            .subscribe(onNext: { value in
//                print(value)
//            })
//        
//        _ = validPasswordObservable
//            .subscribe(onNext: { value in
//                self.passwordTextField.backgroundColor = value
//            })
//    }
}

