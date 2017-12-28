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

enum BikeTrackEndpoint {
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
    case addBikePicture(bikeId: String, pictureData: Data)
    case getPicture()
    case getBikePicture(bikeId: String)
    case addBillPicture(bikeId: String, pictureData: Data)
    case getBillPicture(bikeId: String)
}

extension BikeTrackEndpoint: SugarTargetType {
    var baseURL: URL { return URL(string: "http://163.172.81.184:3000")! }
    
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
        case .getPicture(_):
            return .get("/testPicture")
        case .addBikePicture(_, _):
            return .post("/bikePostPicture")
        case .getBikePicture(let bikeId):
            return .get("/bikeGetPicture/\(bikeId)")
        case .addBillPicture(_,_):
            return .post("/bikePostBill")
        case .getBillPicture(let bikeId):
            return .get("/bikeGetBill/\(bikeId)")
        }
    }
    
    var params: Parameters? {
        switch self {
        case .userLogIn(let mail, let password):
            return JSONEncoding.default => [
                "email": "\(mail)",
                "password": "\(password)"
            ]
        case .userCreate(let mail, let password):
            return JSONEncoding.default => [
                "email": "\(mail)",
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
                    "email": "\(email)",
                    "name": "\(name)",
                    "lastname": "\(lastname)"
                ]
            ]
        case .deleteUser(let userId):
            return JSONEncoding.default => [
                "userId": "\(userId)"
            ]
        case .addBikePicture(let bikeId, _):
            return JSONEncoding.default => [
                "bikeID": "\(bikeId)",
                "photoBike": "image.jpg"
            ]
        default:
            return nil
        }
    }
    
    var task: Task {
        switch self {
        case .addBikePicture(let bikeId, let pictureData):
            let bikeId = MultipartFormData(provider: .data(bikeId.data(using: .utf8)!), name: "bikeId")
            let bikePicture = MultipartFormData(provider: .data(pictureData), name: "photoBike", fileName: "image.jpg",
                                                mimeType: "image/jpg")
            let multipartData = [bikeId, bikePicture]
            return .upload(UploadType.multipart(multipartData))
        case .addBillPicture(let bikeId, let pictureData):
            let bikeId = MultipartFormData(provider: .data(bikeId.data(using: .utf8)!), name: "bikeId")
            let billPicture = MultipartFormData(provider: .data(pictureData), name: "photoBill", fileName: "image.png",
                                                mimeType: "image/png")
            let multipartData = [bikeId, billPicture]
            return .upload(UploadType.multipart(multipartData))
        default:
            return .request
        }
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
        case .getPicture(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .addBikePicture(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .getBikePicture(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .addBillPicture(_):
            return "a remplir plus tard".data(using: .utf8)!
        case .getBillPicture(_):
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
