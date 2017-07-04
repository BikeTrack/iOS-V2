//
//  updateBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 03/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class updateBikeViewController: UIViewController {
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var bikeName: UITextField!
    @IBOutlet weak var bikeBrand: UITextField!
    private var _bike: BikeTest!
    
    var bike: BikeTest {
        get {
            return _bike
        } set {
            _bike = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        bikeName.text = bike.name
        bikeBrand.text = bike.brand
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRx() {
        _ = updateBtn.rx.tap
            .flatMap({return BiketrackAPI.updateBike(bikeId: self.bike.id, name: self.bikeName.text!, brand: self.bikeBrand.text!)})
            .subscribe({ event in
                switch event {
                case .next(let response):
                    print(response)
                    if let dict = response as? Dictionary<String, AnyObject> {
                        if let bike = dict["bike"] as? Dictionary<String, AnyObject> {
                            self.bike.name = bike["name"] as! String
                        }
                    }
                    self.performSegue(withIdentifier: "toOneBikeVC", sender: nil)
                default:
                    print("default update bike")
                }
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneBikeViewController {
            destination.bike = bike
        }
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
