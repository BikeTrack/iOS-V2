//
//  ApiCall.swift
//  Biketrack
//
//  Created by Valentin Wallet on 15/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Foundation
import Alamofire

let API_URL = "https://biketrack-api.herokuapp.com/api/"
typealias loginCompleted = (_ loginSuccess: Bool) -> ()

class BiketrackAPI {
    
    func login(username: String, password: String, completion: @escaping (Bool) -> ()) {
        let parameters: Parameters = [
            "username": "\(username)",
            "password": "\(password)"
        ]
        
        Alamofire.request(API_URL + "users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if (dict["error"] != nil) {
                    completion(false)
                }
                else if (dict["success"] != nil) {
                    completion(true)
                }
            }
        }
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
