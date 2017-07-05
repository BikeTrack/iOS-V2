//
//  trackertest.swift
//  Biketrack
//
//  Created by Valentin Wallet on 04/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Mapper

struct TrackerTest: Mappable {
    var locations: [Location]
    var battery: [Battery]
    
    init(map: Mapper) throws {
        try locations = map.from("locations")
        try battery = map.from("battery")
    }
    
}

struct Location: Mappable {
    var coordinates: [Double]
    
    init(map: Mapper) throws {
        try coordinates = map.from("coordinates")
    }
}

struct Battery: Mappable {
    var percentage: Double
    
    init(map: Mapper) throws {
        try percentage = map.from("pourcentage")
    }
}
