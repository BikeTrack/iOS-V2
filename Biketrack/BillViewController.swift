//
//  BillViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 28/12/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {

    @IBOutlet weak var billImage: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billImage.image = image
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
