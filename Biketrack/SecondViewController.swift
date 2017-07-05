//
//  SecondViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    let menuManager = MenuManager()
    private var _user: UserTest!
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: UserTest {
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
                            (NSLocalizedString("Delete the account", comment: "deleteAccount"), self.deleteUser)]
        setupRx()
        // Do any additional setup after loading the view, typically from a nib.
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

