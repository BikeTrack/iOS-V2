//
//  TableViewCell.swift
//  Biketrack
//
//  Created by Valentin Wallet on 01/11/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(bike: Bike) {
        mainLabel.text = bike.title
        let url = URL(string: bike.image)!

        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.mainImage.image = UIImage(data: data)
                }
            } catch {
                // handle the error
            }
        }
    }
}
