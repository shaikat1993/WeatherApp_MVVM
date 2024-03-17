//
//  WeatherModel.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//


import Foundation
import SwiftyJSON

struct WeatherResponse {
    var count: Int?
    var data: [WeatherData]?
    
    init?(json: JSON) {
        count = json["count"].int
        data = json["data"].arrayValue.compactMap { WeatherData(json: $0) }
    }
}

struct WeatherData {
    var appTemp: Double?
    var aqi: Int?
    var cityName: String?
    var clouds: Int?
    var countryCode: String?
    var datetime: String?
    var dewpt: Int?
    var dhi: Double?
    var dni: Double?
    var elevAngle: Double?
    var ghi: Double?
    var gust: NSNull?
    var hAngle: Int?
    var lat: Double?
    var lon: Double?
    var obTime: String?
    var pod: String?
    var precip: Int?
    var pres: Double?
    var rh: Int?
    var slp: Int?
    var snow: Int?
    var solarRAD: Double?
    var sources: [String]?
    var stateCode: String?
    var station: String?
    var sunrise: String?
    var sunset: String?
    var temp: Int?
    var timezone: String?
    var ts: Int?
    var uv: Double?
    var vis: Int?
    var weatherDesc: WeatherDescription?
    var windCdir: String?
    var windCdirFull: String?
    var windDir: Int?
    var windSpd: Double?
    
    init?(json: JSON) {
        guard let appTemp = json["app_temp"].double,
              let aqi = json["aqi"].int,
              let cityName = json["city_name"].string,
              let clouds = json["clouds"].int,
              let countryCode = json["country_code"].string,
              let datetime = json["datetime"].string,
              let dewpt = json["dewpt"].int,
              let dhi = json["dhi"].double,
              let dni = json["dni"].double,
              let elevAngle = json["elev_angle"].double,
              let ghi = json["ghi"].double,
              let hAngle = json["h_angle"].int,
              let lat = json["lat"].double,
              let lon = json["lon"].double,
              let obTime = json["ob_time"].string,
              let pod = json["pod"].string,
              let precip = json["precip"].int,
              let pres = json["pres"].double,
              let rh = json["rh"].int,
              let slp = json["slp"].int,
              let snow = json["snow"].int,
              let solarRAD = json["solar_rad"].double,
              let sources = json["sources"].array?.compactMap({ $0.string }),
              let stateCode = json["state_code"].string,
              let station = json["station"].string,
              let sunrise = json["sunrise"].string,
              let sunset = json["sunset"].string,
              let temp = json["temp"].int,
              let timezone = json["timezone"].string,
              let ts = json["ts"].int,
              let uv = json["uv"].double,
              let vis = json["vis"].int,
              let weatherDescJSON = json["weather"].dictionary,
              let weatherDesc = WeatherDescription(json: JSON(weatherDescJSON)),
              let windCdir = json["wind_cdir"].string,
              let windCdirFull = json["wind_cdir_full"].string,
              let windDir = json["wind_dir"].int,
              let windSpd = json["wind_spd"].double
        else { return nil }
        
        self.appTemp = appTemp
        self.aqi = aqi
        self.cityName = cityName
        self.clouds = clouds
        self.countryCode = countryCode
        self.datetime = datetime
        self.dewpt = dewpt
        self.dhi = dhi
        self.dni = dni
        self.elevAngle = elevAngle
        self.ghi = ghi
        self.hAngle = hAngle
        self.lat = lat
        self.lon = lon
        self.obTime = obTime
        self.pod = pod
        self.precip = precip
        self.pres = pres
        self.rh = rh
        self.slp = slp
        self.snow = snow
        self.solarRAD = solarRAD
        self.sources = sources
        self.stateCode = stateCode
        self.station = station
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.timezone = timezone
        self.ts = ts
        self.uv = uv
        self.vis = vis
        self.weatherDesc = weatherDesc
        self.windCdir = windCdir
        self.windCdirFull = windCdirFull
        self.windDir = windDir
        self.windSpd = windSpd
    }
}

struct WeatherDescription {
    var code: Int?
    var icon: String?
    var description: String?
    
    init?(json: JSON) {
        guard let code = json["code"].int,
              let icon = json["icon"].string,
              let description = json["description"].string
        else { return nil }
        
        self.code = code
        self.icon = icon
        self.description = description
    }
    
    //Own icon sets
    func getIcon()->String {
        
        switch icon {
        case "t01d","t02d","t03d","t01n","t02n","t03n" :
            return "cloud.bolt.rain"
        case "t04d","t04n","t05d","t05n": 
            return "cloud.bolt"
        case "d01d","d01n","d02d","d02n","d03d","d03n": 
            return "cloud.drizzle"
        case "r01d", "r01n","r02d","r02n": 
            return "cloud.rain"
        case "r03d","r03n": 
            return "cloud.heavyrain"
        case "f01d","f01n","r04d","r04n","r05d","r05n","r06d","r06n": 
            return "cloud.rain"
        case "s01d","s01n","s02d","s02n","s03d","s03n","s04d","s04n": 
            return "cloud.snow"
        case "s05d","s05n": 
            return "cloud.sleet"
        case "a01d","a01n","a02d","a02n","a03d","a03n","a04d","a04n","a05d","a05n","a06d","a06n": 
            return "smoke"
        case "c01d","c01n": 
            return "sun.max"
        case "c02d", "c02n","c03d","c03n": 
            return "cloud.sun"
        case "c04d","c04n": 
            return "smoke"
        default:
            return "cloud"
        }
    }
}
