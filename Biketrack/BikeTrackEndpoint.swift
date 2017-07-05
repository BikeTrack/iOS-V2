//
//  BikeTrackEndpoint.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar

enum BikeTrackTestRx {
    case userLogIn(mail: String, password: String)
    case userCreate(mail: String, password: String)
    case userInfo(userId: String)
    case bikeInfo(bikeId: String)
    case createBike(userId: String, name: String, brand: String)
    case deleteBike(bikeId: String, userId: String)
    case updateBike(bikeId: String, name: String, brand: String)
    case getLocations(trackerId: String)
    case updateUser(userId: String, email: String, name: String, lastname: String)
    case deleteUser(userId: String)
}

extension BikeTrackTestRx: SugarTargetType {
    var baseURL: URL { return URL(string: "https://bike-track-api.herokuapp.com")! }
    
    var route: Route {
        switch self {
        case .userLogIn(_):
            return .post("/authenticate")
        case .userCreate(_):
            return .post("/signup")
        case .userInfo(let userId):
            return .get("/profile/\(userId)")
        case .bikeInfo(let bikeId):
            return .get("/bike/\(bikeId)")
        case .createBike( _, _, _):
            return .post("/bike")
        case .deleteBike(_, _):
            return .delete("/bike")
        case .updateBike(_,_,_):
            return .patch("/bike")
        case .getLocations(let trackerId):
            return .get("/tracker/\(trackerId)")
        case .updateUser(_, _, _, _):
            return .patch("/profile")
        case .deleteUser(_):
            return .delete("/profile")
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
        case .createBike(let userId, let name, let brand):
            return JSONEncoding.default => [
                "userId": "\(userId)",
                "bikeInfo": [
                    "name": "\(name)",
                    "brand": "\(brand)",
                    "tracker": "7462C"
                ]
            ]
        case .deleteBike(let bikeId, let userId):
            return JSONEncoding.default => [
                "bikeId": "\(bikeId)",
                "userId": "\(userId)"
            ]
        case .updateBike(let bikeId, let name, let brand):
            return JSONEncoding.default => [
                "bikeId": "\(bikeId)",
                "update": [
                    "name": "\(name)",
                    "brand": "\(brand)"
                ]
            ]
        case .updateUser(let userId, let email, let name, let lastname):
            return JSONEncoding.default => [
                "userId": "\(userId)",
                "update": [
                    "mail": "\(email)",
                    "name": "\(name)",
                    "lastname": "\(lastname)"
                ]
            ]
        case .deleteUser(let userId):
            return JSONEncoding.default => [
                "userId": "\(userId)"
            ]
        default:
            return nil
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
        case .userInfo(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .bikeInfo(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .createBike(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .deleteBike(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .updateBike(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .getLocations(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .updateUser(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .deleteUser(_):
            return "a remplir plus tard".data(using: .utf8)!
        }
    }
    
    var httpHeaderFields: [String: String]? {
        switch self {
            
            
        default:
            return ["Authorization": "9E34BA33E63D1C25AC7834971C211139936C68394FEBE2BC2EA5B5F7F8664F0"]
        }
    }
    
}
