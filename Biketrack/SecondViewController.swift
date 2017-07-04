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
    
    var user: UserTest {
        get {
            return _user
        } set {
            _user = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuManager.items = [("Modifier le compte", self.updateUser),
                             ("Supprimer le compte", self.deleteUser)]
        setupRx()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func updateUser() {
        self.performSegue(withIdentifier: "toUpdateUserVC", sender: nil)
    }
    
    func deleteUser() {
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
                    self._user = response
                    self.userName.text = response.mail
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

