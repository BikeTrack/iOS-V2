//
//  biketest.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Mapper

struct BikeTest: Mappable {
    var name: String
    var brand: String?
    var tracker: String
    var id: String
    var batteryPercentage: Double
    var img: BikeImage?
    
    init(map: Mapper) throws {
        try name = map.from("name")
        try brand = map.optionalFrom("brand")
        try tracker = map.from("tracker")
        try id = map.from("_id")
        img = map.optionalFrom("img")
        batteryPercentage = 0
    }
}

struct BikeImage: Mappable {
    var buffer: String
    var contentType: String
    
    init(map: Mapper) throws {
        try buffer = map.from("buffer")
        try contentType = map.from("contentType")
    }
}
