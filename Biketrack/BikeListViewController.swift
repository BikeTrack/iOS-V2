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
    // UI
    @IBOutlet weak var tableView: UITableView!
    
    // Data
    var refreshControl: UIRefreshControl!
    let disposeBag = DisposeBag()
    let dataSource = Variable<[Bike]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        getBikes()
        setupRx()
    }
    
    // MARK: - Refresh
    func setupRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        getBikes(refresh: true)
    }
    
    // MARK: - Get Data
    
    func getBikeList(completion: @escaping ([Bike]) -> Void) {
        let bikeList = BiketrackAPI.getUserInfo()
            .flatMap { user -> Observable<[String]> in
                return Observable.from(user.bikes)
            }
            .flatMap {
                Observable.from($0)
            }
            .flatMap { bikeId -> Observable<Bike> in
                return BiketrackAPI.getBikeInfo(bikeId: bikeId)
            }
            .flatMap { bike -> Observable<Bike> in
                return BiketrackAPI.getBattery(bike: bike)
            }.toArray()
        
        _ = bikeList.subscribe { event in
            switch event {
            case .next(let response):
                completion(response)
            default:
                print("default subscribe to get bikes")
            }
        }
    }
    
    func getBikes(refresh: Bool = false) {
        self.refreshControl.beginRefreshing()
        getBikeList() { bikes in
            self.dataSource.value = bikes
            for (index, bike) in bikes.enumerated() {
                _ = BiketrackAPI.getBikePicture(bike: bike).subscribe { event in
                    switch event {
                    case .next(let response):
                        self.dataSource.value[index].bikeImage = response.bikeImage
                    case .error(let error):
                        print(error)
                    default:
                        print("default get bike pictures")
                    }
                }
                _ = BiketrackAPI.getBikeBill(bike: bike).subscribe { event in
                    switch event {
                    case .next(let response):
                        print("on add")
                        self.dataSource.value[index].bikeBill = response.bikeBill
                    case .error(let error):
                        print("error: \(error)")
                    default:
                        print("wesh la bill")
                    }
                }
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: Rx Table View
    func setupRx() {
        dataSource.asObservable().bindTo(tableView.rx.items(cellIdentifier: "BikeCell")) {
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
                    if bike.bikeImage != "" {
                        let dataDecoded : Data = Data(base64Encoded: bike.bikeImage, options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
                        cellToUse.bikeImage.image = decodedimage
                    } else {
                        cellToUse.bikeImage.image = UIImage(named: "001-bicycle")
                    }
                }
        }.addDisposableTo(disposeBag)
        
        _ = tableView.rx.modelSelected(Bike.self)
            .subscribe( onNext: {bike in
                self.performSegue(withIdentifier: "OneBike", sender: bike)
            }
        )
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneBikeViewController {
            if let oneBike = sender as? Bike {
                destination.bike = oneBike
            }
        }
    }

}

