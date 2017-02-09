//
//  BikeTrackEndpoint.swift
//  Biketrack
//
//  Created by Valentin Wallet on 09/02/2017.
//  Copyright © 2017 Biketrack. All rights reserved.
//

import Foundation
import Moya

enum BikeTrackTestRx {
    case userLogIn(username: String, password: String)
}

extension BikeTrackTestRx: TargetType {
    var baseURL: URL {return URL(string: "https://biketrack-api.herokuapp.com/api")!}
    
    var path: String {
        switch self {
            case .userLogIn(_):
                return "/users/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .userLogIn(_):
                return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .userLogIn(let username, let password):
            return [
                "username": "\(username)",
                "password": "\(password)"
            ]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .userLogIn(_):
            return "{\"username\": \"toto\", \"password\": \"titi\"}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
