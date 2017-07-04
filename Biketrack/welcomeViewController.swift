//
//  welcomeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 15/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class welcomeViewController: UIViewController {

    @IBOutlet weak var LogoOnTop: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var bikes = [Bike]()
    var bikestab = [String]()
    static var bikesfinal = [Bike]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        
        let velo1 = Bike(image: "http://macadamcycles.com/3627-thickbox_default/extra-extrema-fixie-polish-columbus.jpg", title: "velo1", lat: 40.5, long: 68)
        let velo2 = Bike(image: "https://urban-fixie.com/media/catalog/product/cache/1/small_image/500x/21b2a4e09582ace586d8b86eff8f0f99/m/o/montage-aventon-mataro-low-blue-urban-fixie-.jpg", title: "velo2", lat: 40.5, long: 68)
        let velo3 = Bike(image: "http://i-cms.journaldunet.com/image_cms/original/1883975-le-fixie-un-velo-sans-freins-ni-derailleur-mais-qui-s-arrache.jpg", title: "velo3", lat: 40.5, long: 68)

        bikes.append(velo1)
        bikes.append(velo2)
        bikes.append(velo3)
    }
    
    func getBikes(response: Any) -> [String] {
        if let dict = response as? Dictionary<String, AnyObject> {
            if let user = dict["user"] as? Dictionary<String, AnyObject> {
                if let result = user["bikes"] as? [String] {
                    return result
                }
            }
        }
        return [String]()
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
            .toArray()
            .bindTo(tableView.rx.items(cellIdentifier: "BikeCell")) {
                _, bike, cell in
                if let cellToUse = cell as? TableViewCell {
                    cellToUse.mainLabel.text = bike.name
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
    
    @IBAction func LogOutBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneBikeViewController {
            if let oneBike = sender as? BikeTest {
                destination.bike = oneBike
            }
        }
    }
}
