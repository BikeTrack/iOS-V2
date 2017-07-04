//
//  usertest.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Mapper

struct UserTest: Mappable {
    
    var mail: String
    var bikes: [String]
    
    init(map: Mapper) throws {
        try mail = map.from("mail")
        try bikes = map.from("bikes")
    }
}
