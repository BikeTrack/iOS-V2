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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    // UI
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
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Swift.Error!) {
        print(result.token.tokenString)
    }
  
    @IBAction func facebookLoginPushed(_ sender: Any) {
        if let currentToken = FBSDKAccessToken.current().tokenString {
            print("déjà un token")
        } else {
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if let currentToken = FBSDKAccessToken.current().tokenString {
            _ = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print("pas d'erreur")
                    if let dict = result as? [String: String] {
                        // Test de connexion
                        if let email = dict["email"] {
                            _ = BiketrackAPI.signup(username: email, password: currentToken).subscribe { event in
                                switch event {
                                case .next(let response):
                                    print(response)
                                    _ = BiketrackAPI.login(username: email, password: currentToken).subscribe { event in
                                        switch event {
                                        case .next(let response):
                                            self.printResponse(response: response) ? self.performSegue(withIdentifier: "toTBC", sender: nil) : print("error")
                                        default:
                                            print("default login fb apres signup")
                                            
                                        }
                                    }
                                default:
                                    print("default signup facebook")
                                }
                            }
                        }
                    }
                    
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
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
