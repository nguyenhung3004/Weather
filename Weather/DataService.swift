//
//  DataService.swift
//  Weather
//
//  Created by Hung Nguyen on 5/28/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    static let shared: DataService = DataService()
    var weather: JSON = []
    func requestAPI(){
        Alamofire.request("https://api.darksky.net/forecast/f3367c0bed2b29a7a1c0d1f6ce4b815b/37.8267,-122.4233").responseJSON { (response) in
            guard let json = response.result.value as? [String : AnyObject] else {return}
            let swiftyJson = JSON(json)
            self.weather = swiftyJson
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "1"), object: nil, userInfo: nil)
        }
    }
}
