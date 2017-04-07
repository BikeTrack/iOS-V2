//
//  ApiCall.swift
//  Biketrack
//
//  Created by Valentin Wallet on 15/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import Moya
import MoyaSugar
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
    
    var token = ""
    let provider = RxMoyaSugarProvider<BikeTrackTestRx>()
    
    func login(username: String, password: String) -> Observable<Any> {
        print("on est sur du login")
        return provider.request(BikeTrackTestRx.userLogIn(mail: username, password: password)).mapJSON()
    }
    
    func signup(username: String, password: String) -> Observable<Any> {
        print("on signup ")
        return provider.request(BikeTrackTestRx.userCreate(mail: username, password: password)).mapJSON()
    }
    
    func setToken(token: String) {
        self.token = token
    }
}
