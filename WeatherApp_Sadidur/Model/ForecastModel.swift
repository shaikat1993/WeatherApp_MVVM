//
//  ForecastModel.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import Foundation
import SwiftyJSON

struct ForecastResponse {
    var list : [ForecastModel]?
   
    init?(json: JSON) {
        guard let listJSON = json["data"].array else { return nil }
        self.list = listJSON.compactMap { ForecastModel(json: $0) }
    }
}

struct ForecastModel {
    var temp : Int?
    var datetime : String?
    var weather: WeatherDescription?

    init?(json: JSON) {
        guard let temp = json["temp"].int,
              let datetime = json["datetime"].string,
              let weatherDescJSON = json["weather"].dictionary,
              let weatherDesc = WeatherDescription(json: JSON(weatherDescJSON)) else { return nil }
        self.datetime = datetime
        self.temp = temp
        self.weather = weatherDesc
    }
}
