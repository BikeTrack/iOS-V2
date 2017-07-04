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

class FirstViewController: UIViewController {

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
            .flatMap { bikeId -> Observable<BikeTest> in
                return BiketrackAPI.getBikeInfo(bikeId: bikeId)
            }
            .flatMap { bike -> Observable<BikeTest> in
                return BiketrackAPI.getBattery(bike: bike)
            }
            .toArray()
            .bindTo(tableView.rx.items(cellIdentifier: "BikeCell")) {
                _, bike, cell in
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
        tableView.rx.modelSelected(BikeTest.self)
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
            if let oneBike = sender as? BikeTest {
                destination.bike = oneBike
            }
        }
    }

}

