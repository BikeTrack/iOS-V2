//
//  testbike.swift
//  Biketrack
//
//  Created by Valentin Wallet on 01/07/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
//

import Foundation
import Mapper

struct BikeTest: Mappable {
    var name: String
    var color: String
    var brand: String
    var tracker: String
    
    init(map: Mapper) throws {
        try name = map.from("name")
        try color = map.from("color")
        try brand = map.from("brand")
        try tracker = map.from("tracker")
    }
}
