//
//  testuser.swift
//  Biketrack
//
//  Created by Valentin Wallet on 01/07/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
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
