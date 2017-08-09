//
//  usertest.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Mapper

struct User: Mappable {
    
    var mail: String
    var bikes: [String]
    var name: String?
    var lastname: String?
    
    init(map: Mapper) throws {
        try mail = map.from("mail")
        try bikes = map.from("bikes")
        name = map.optionalFrom("name")
        lastname = map.optionalFrom("lastname")
    }
}
