//
//  bike.swift
//  Biketrack
//
//  Created by Valentin Wallet on 01/11/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Foundation

class Bike {
    private var _image: String!
    private var _title: String!
    private var _lat: Float
    private var _long: Float
    
    var image : String {
        return _image
    }
    
    var title : String {
        return _title
    }
    
    var lat : Float {
        return _lat
    }
    
    var long : Float {
        return _long
    }
    
    init(image: String, title: String, lat: Float, long: Float) {
        _image = image
        _title = title
        _lat = lat
        _long = long
    }
}
