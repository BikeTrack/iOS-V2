//
//  OneBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 01/11/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import UIKit

class OneBikeViewController: UIViewController {

    @IBOutlet weak var bikeImg: UIImageView!
    @IBOutlet weak var bikeTitle: UILabel!
    private var _bike: BikeTest!
    @IBOutlet weak var viewGMAP: UIView!
    
    var bike: BikeTest {
        get {
            return _bike
        } set {
            _bike = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTitle.text = bike.name
        
//        let url = URL(string: bike.image)!
        
//        DispatchQueue.global().async {
//            do {
//                let data = try Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    self.bikeImg.image = UIImage(data: data)
//                }
//            } catch {
//                // handle the error
//            }
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GmapViewController {
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
