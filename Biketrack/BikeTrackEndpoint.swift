//
//  BikeTrackEndpoint.swift
//  Biketrack
//
//  Created by Valentin Wallet on 09/02/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar

enum BikeTrackTestRx {
    case userLogIn(mail: String, password: String)
    case userCreate(mail: String, password: String)
}

extension BikeTrackTestRx: SugarTargetType {
    var baseURL: URL { return URL(string: "https://bike-track-api.herokuapp.com")! }
    
    var route: Route {
        switch self {
            case .userLogIn(_):
                return .post("/authenticate")
            case .userCreate(_):
                return .post("/signup")
        }
    }
    
    var params: Parameters? {
        switch self {
        case .userLogIn(let mail, let password):
            return JSONEncoding.default => [
                "mail": "\(mail)",
                "password": "\(password)"
            ]
        case .userCreate(let mail, let password):
            return JSONEncoding.default => [
                "mail": "\(mail)",
                "password": "\(password)"
            ]
        }
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        case .userLogIn(_):
            return "{\"username\": \"toto\", \"password\": \"titi\"}".data(using: .utf8)!
        case .userCreate(_):
            return "{\"username\": \"toto\", \"password\": \"titi\"}".data(using: .utf8)!
        }
    }

    var httpHeaderFields: [String: String]? {
        switch self {
            

        default:
            return ["Authorization": "9E34BA33E63D1C25AC7834971C211139936C68394FEBE2BC2EA5B5F7F8664F0"]
        }
    }
    
}
