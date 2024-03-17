//
//  Constant.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import Foundation

struct Constant {
    static let APIKey                 = "50aa4f6898c340519aa1413c1ce1a5b2"
    static let baseURL                = "https://api.weatherbit.io/v2.0/"

    struct URL {
        static let getCurrentWeatherForCity = baseURL + "current?city=%@&key=\(APIKey)&include=minutely"
        static let getCurrentWeather = baseURL + "current?lat=%@&lon=%@&key=\(APIKey)&include=minutely"
        static let getSevenDayForcast = baseURL + "forecast/daily?city=%@&days=7&key=\(APIKey)"

    }
}
