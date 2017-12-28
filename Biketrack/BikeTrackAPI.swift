//
//  BikeTrackAPI.swift
//  Biketrack
//
//  Created by Valentin Wallet on 02/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar
import Mapper
import Moya_ModelMapper
import Foundation
import Alamofire
import RxSwift
import RxCocoa

/*
 ** Class pour tout ce qui concerne l'interaction avec l'api.
 ** Voir le fichier BikeTrackEndpoint.swift pour la configuration
 ** de la librairie moya utile aux requêtes
 */

class BiketrackAPI {
    
    static var token = ""
    static var userId = ""
    
    static var provider = RxMoyaSugarProvider<BikeTrackEndpoint>()
    
    static func login(username: String, password: String) -> Observable<Any> {
        print("on est sur du login")
        return provider.request(BikeTrackEndpoint.userLogIn(mail: username, password: password)).mapJSON()
    }
    
    static func getPicture() -> Observable<String> {
        return provider.request(BikeTrackEndpoint.getPicture()).mapString()
    }
    
    static func signup(username: String, password: String) -> Observable<Any> {
        print("on signup ")
        return provider.request(BikeTrackEndpoint.userCreate(mail: username, password: password)).mapJSON()
    }
    
    static func getUserInfo() -> Observable<User> {
        let endpointClosure: (BikeTrackEndpoint) -> Endpoint<BikeTrackEndpoint> = { target in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint
                .adding(newHTTPHeaderFields: ["x-access-token": BiketrackAPI.token])
                .adding(newHTTPHeaderFields: ["Authorization": "9E34BA33E63D1C25AC7834971C211139936C68394FEBE2BC2EA5B5F7F8664F0"])
        }
        provider = RxMoyaSugarProvider<BikeTrackEndpoint>(endpointClosure: endpointClosure)
        return provider.request(BikeTrackEndpoint.userInfo(userId: BiketrackAPI.userId)).mapObject(type: User.self, keyPath: "user")
    }
    
    static func addBikePicture(bikeId: String, pictureData: Data) -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.addBikePicture(bikeId: bikeId, pictureData: pictureData)).mapJSON()
    }
    
    static func addBillPicture(bikeId: String, pictureData: Data) -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.addBillPicture(bikeId: bikeId, pictureData: pictureData)).mapJSON()
    }
    
    static func getBikeInfo(bikeId: String) -> Observable<Bike> {
        print("ca fail ?")
        return provider.request(BikeTrackEndpoint.bikeInfo(bikeId: bikeId)).mapObject(type: Bike.self, keyPath: "bike")
    }
    
    static func debugBattery(bike: Bike) -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.getLocations(trackerId: "7462C")).mapJSON()
    }
    
    static func getBattery(bike: Bike) -> Observable<Bike> {
        return provider.request(BikeTrackEndpoint.getLocations(trackerId: "7462C")).mapObject(type: Tracker.self, keyPath: "tracker").flatMap({ tracker -> Observable<Bike> in
            var newBike: Bike = bike
            newBike.batteryPercentage = (tracker.battery.last?.percentage)!
            return Observable.from(newBike)
        })
    }
    
    static func getBikePicture(bike: Bike) -> Observable<Bike> {
        return provider.request(BikeTrackEndpoint.getBikePicture(bikeId: bike.id)).mapString().flatMap({ imageString -> Observable<Bike> in
            if imageString.count == "{\"success\":false,\"e\":{}}".count {
                print("c'est une erreur")
            } else {
                var newBike: Bike = bike
                newBike.bikeImage = imageString
                return Observable.from(newBike)
            }
            return Observable.from(bike)
        })
    }
    
    static func getBikeBill(bike: Bike) -> Observable<Bike> {
        print("getBikeBill")
        return provider.request(BikeTrackEndpoint.getBillPicture(bikeId: bike.id)).mapString().flatMap({ imageString -> Observable<Bike> in
            print("ici")
            if imageString.count == "{\"success\":false,\"e\":{}}".count {
                print("c'est une erreur de bill")
            } else {
                print("on add la bill")
                var newBike: Bike = bike
                newBike.bikeBill = imageString
                return Observable.from(newBike)
            }
            return Observable.from(bike)
        })
    }
    
    static func deleteBike(bikeId: String) -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.deleteBike(bikeId: bikeId, userId: BiketrackAPI.userId)).mapJSON()
    }
    
    static func updateBike(bikeId: String, name: String, brand: String, image: String) -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.updateBike(bikeId: bikeId, name: name, brand: brand)).mapJSON()
    }
    
    static func createABike(name: String, brand: String) -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.createBike(userId: userId, name: name, brand: brand)).mapJSON()
    }
    
    static func getLocations() -> Observable<Tracker> {
        return provider.request(BikeTrackEndpoint.getLocations(trackerId: "7462C")).mapObject(type: Tracker.self, keyPath: "tracker")
    }
    
    static func updateUser(email: String, name: String, lastname: String) -> Observable<User> {
        return provider.request(BikeTrackEndpoint.updateUser(userId: userId, email: email, name: name, lastname: lastname)).mapObject(type: User.self, keyPath: "user")
    }
    
    static func deleteUser() -> Observable<Any> {
        return provider.request(BikeTrackEndpoint.deleteUser(userId: userId)).mapJSON()
    }
    
    static func setToken(token: String) {
        BiketrackAPI.token = token
    }
    
    static func setUserId(userId: String) {
        BiketrackAPI.userId = userId
    }
    
}
