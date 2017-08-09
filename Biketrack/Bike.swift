//
//  biketest.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Mapper

struct Bike: Mappable {
    var name: String
    var brand: String?
    var tracker: String
    var id: String
    var batteryPercentage: Double
    
    init(map: Mapper) throws {
        try name = map.from("name")
        brand = map.optionalFrom("brand")
        try tracker = map.from("tracker")
        try id = map.from("_id")
        batteryPercentage = 0
    }
}

