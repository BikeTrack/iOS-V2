//
//  FirstViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BikeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupRx() {
        print("setup rx")
        var bikeList = BiketrackAPI.getUserInfo()
            .flatMap { user -> Observable<[String]> in
                return Observable.from(user.bikes)
            }
            .flatMap {
                Observable.from($0)
            }
            .flatMap { bikeId -> Observable<Bike> in
                print("biiiikkkeeIDDD")
                print(bikeId)
                return BiketrackAPI.getBikeInfo(bikeId: bikeId)
            }
            .flatMap { bike -> Observable<Bike> in
                print("biiiiike")
                print(bike)
                return BiketrackAPI.getBattery(bike: bike)
            }
            .toArray()
            .bindTo(tableView.rx.items(cellIdentifier: "BikeCell")) {
                _, bike, cell in
                print(bike)
                if let cellToUse = cell as? TableViewCell {
                    switch bike.batteryPercentage {
                    case 0...10:
                        cellToUse.bikeBatteryImage.image = UIImage(named: "002-empty-battery")
                    case 10...30:
                        cellToUse.bikeBatteryImage.image = UIImage(named: "001-battery")
                    default:
                        cellToUse.bikeBatteryImage.image = UIImage(named: "003-technology")
                    }
                    cellToUse.bikeName.text = bike.name
                    
                }
        }
        _ = tableView.rx.modelSelected(Bike.self)
            .subscribe( onNext: {bike in
                self.performSegue(withIdentifier: "OneBike", sender: bike)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneBikeViewController {
            if let oneBike = sender as? Bike {
                destination.bike = oneBike
            }
        }
    }

}

