//
//  SecondViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language
class L102Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}

class UserViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    let menuManager = MenuManager()
    private var _user: User!
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User {
        get {
            return _user
        } set {
            _user = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuManager.items = [(NSLocalizedString("Modify the account", comment: "modifyAccount"), self.updateUser),
                             (NSLocalizedString("Log out", comment: "logout"), self.logOut),
                            (NSLocalizedString("Delete the account", comment: "deleteAccount"), self.deleteUser),
        (NSLocalizedString("Change the language to French", comment: "ChangeLanguage"), self.changeLanguage)]
        setupRx()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func changeLanguage() {
        menuManager.dissmissMenu()
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "fr")
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
        }
        let transition: UIViewAnimationOptions = .transitionFlipFromLeft
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "toRootVC")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
    func updateUser() {
        menuManager.dissmissMenu()
        self.performSegue(withIdentifier: "toUpdateUserVC", sender: nil)
    }
    
    func deleteUser() {
        _ = BiketrackAPI.deleteUser()
            .subscribe({event in
                switch event {
                case .next(let response):
                    print(response)
                    self.menuManager.dissmissMenu()
                    self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                default:
                    print("default")
                }
            })
    }
    
    func logOut() {
        self.menuManager.dissmissMenu()
        self.performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
    @IBAction func moreBtn(_ sender: Any) {
        menuManager.openMenu()
    }
    
    func setupRx() {
        _ = BiketrackAPI.getUserInfo()
            .subscribe({event in
                switch event {
                case .next(let response):
                    print(response)
                    self._user = response
                    self.userName.text = response.mail
                    self.firstnameLbl.text = response.name
                    self.nameLabel.text = response.lastname
                default:
                    print("default svc")
                }
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? updateUserViewController {
            destination.user = user
        }
    }


}

