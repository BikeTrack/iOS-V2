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
    private var _brand: String!
    private var _color: String!
    
    var brand : String {
        return _brand
    }
    
    var color : String {
        return _color
    }
    
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
    
    init(title: String) {
        _image = "http://france3-regions.francetvinfo.fr/auvergne-rhone-alpes/sites/regions_france3/files/styles/top_big/public/assets/images/2016/04/25/fixie_1.jpg?itok=RENG_8nh"
        _title = title
        _lat = 50.0
        _long = 50.0
    }
}
