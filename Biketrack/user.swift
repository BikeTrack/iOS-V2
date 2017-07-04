//
//  User.swift
//  Biketrack
//
//  Created by Valentin Wallet on 01/07/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
//

import Foundation

class User {
    private var _name: String!
    private var _lastname: String!
    private var _mail: String!
    private var _bikes: [String]
    
    var name : String {
        return _name
    }
    
    var lastname : String {
        return _lastname
    }
    
    var mail : String {
        return _mail
    }
    
    var bikes : [String] {
        return _bikes
    }
    
    init(name: String, lastname: String, mail: Float, bikes: Float) {
        _name = name
        _lastname = lastname
        _mail = mail
        _bikes = bikes
    }
}
