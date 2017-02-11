//
//  ApiCall.swift
//  Biketrack
//
//  Created by Valentin Wallet on 15/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Moya
import Moya_ModelMapper
import Foundation
import Alamofire
import RxSwift
import RxCocoa


let API_URL = "https://biketrack-api.herokuapp.com/api/"

class BiketrackAPI {
    
    var provider: RxMoyaProvider<BikeTrackTestRx>
    
    init() {
        provider = RxMoyaProvider<BikeTrackTestRx>()
    }
    
    func login(username: String, password: String) -> Observable<Any> {
        return self.provider.request(BikeTrackTestRx.userLogIn(username: username, password: password)).mapJSON()
    }
    
    func createAccount(username: String, password: String, completion: @escaping (Bool) -> ()) {
        let parameters: Parameters = [
            "username": "\(username)",
            "password": "\(password)"
        ]
        
        Alamofire.request(API_URL + "users", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if (dict["error"] != nil) {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
