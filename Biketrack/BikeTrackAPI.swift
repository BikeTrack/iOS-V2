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
    
    static var provider = RxMoyaSugarProvider<BikeTrackTestRx>()
    
    static func login(username: String, password: String) -> Observable<Any> {
        print("on est sur du login")
        return provider.request(BikeTrackTestRx.userLogIn(mail: username, password: password)).mapJSON()
    }
    
    static func signup(username: String, password: String) -> Observable<Any> {
        print("on signup ")
        return provider.request(BikeTrackTestRx.userCreate(mail: username, password: password)).mapJSON()
    }
    
    static func getUserInfo() -> Observable<UserTest> {
        let endpointClosure: (BikeTrackTestRx) -> Endpoint<BikeTrackTestRx> = { target in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint
                .adding(newHTTPHeaderFields: ["x-access-token": BiketrackAPI.token])
                .adding(newHTTPHeaderFields: ["Authorization": "9E34BA33E63D1C25AC7834971C211139936C68394FEBE2BC2EA5B5F7F8664F0"])
        }
        provider = RxMoyaSugarProvider<BikeTrackTestRx>(endpointClosure: endpointClosure)
        return provider.request(BikeTrackTestRx.userInfo(userId: BiketrackAPI.userId)).mapObject(type: UserTest.self, keyPath: "user")
    }
    
    static func getBikeInfo(bikeId: String) -> Observable<BikeTest> {
        return provider.request(BikeTrackTestRx.bikeInfo(bikeId: bikeId)).mapObject(type: BikeTest.self, keyPath: "bike")
    }
    
    static func getBattery(bike: BikeTest) -> Observable<BikeTest> {
        return provider.request(BikeTrackTestRx.getLocations(trackerId: "71test")).mapObject(type: TrackerTest.self, keyPath: "tracker").flatMap({ tracker -> Observable<BikeTest> in
            var newBike: BikeTest = bike
            newBike.batteryPercentage = (tracker.battery.last?.percentage)!
            return Observable.from(newBike)
        })
    }
    
    static func deleteBike(bikeId: String) -> Observable<Any> {
        return provider.request(BikeTrackTestRx.deleteBike(bikeId: bikeId, userId: BiketrackAPI.userId)).mapJSON()
    }
    
    static func updateBike(bikeId: String, name: String, brand: String) -> Observable<Any> {
        return provider.request(BikeTrackTestRx.updateBike(bikeId: bikeId, name: name, brand: brand)).mapJSON()
    }
    
    static func createABike(name: String, brand: String) -> Observable<Any> {
        return provider.request(BikeTrackTestRx.createBike(userId: userId, name: name, brand: brand)).mapJSON()
    }
    
    static func getLocations() -> Observable<TrackerTest> {
        return provider.request(BikeTrackTestRx.getLocations(trackerId: "7462C")).mapObject(type: TrackerTest.self, keyPath: "tracker")
    }
    
    static func updateUser(email: String, name: String, lastname: String) -> Observable<Any> {
        return provider.request(BikeTrackTestRx.updateUser(userId: userId, email: email, name: name, lastname: lastname)).mapJSON()
    }
    static func setToken(token: String) {
        BiketrackAPI.token = token
    }
    
    static func setUserId(userId: String) {
        BiketrackAPI.userId = userId
    }
    
}
