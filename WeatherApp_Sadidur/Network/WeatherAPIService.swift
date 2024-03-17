//
//  WeatherService.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import Foundation
import SwiftyJSON


class WeatherAPIService {
    enum APIError: Error {
        case invalidResponse
        case networkError
        case jsonParsingError
    }
    
    //    static func getCurrentWeather(lat: String, lon: String,
    //                                  completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
    //        let currentWeatherUrlStr = String(format: Constant.URL.getCurrentWeather, lat, lon)
    //        guard let url = URL(string: currentWeatherUrlStr) else {
    //            completion(.failure(APIError.invalidResponse))
    //            return
    //        }
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            guard let data = data, error == nil else {
    //                completion(.failure(APIError.networkError))
    //                return
    //            }
    //
    //            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
    //                completion(.failure(APIError.invalidResponse))
    //                return
    //            }
    //            // Parse JSON using SwiftyJSON
    //            do {
    //                let json = try JSON(data: data)
    //                guard let weatherResponse = WeatherResponse(json: json) else {
    //                    completion(.failure(APIError.jsonParsingError))
    //                    return
    //                }
    //                completion(.success(weatherResponse))
    //            } catch {
    //                completion(.failure(APIError.jsonParsingError))
    //            }
    //        }.resume()
    //    }
    //
    //    static func getSevenDayWeatherForcast(for cityName: String,
    //                                          completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
    //        let sevenDaysWeatherForcastURLSTR = String(format: Constant.URL.getSevenDayForcast, cityName)
    //        guard let url = URL(string: sevenDaysWeatherForcastURLSTR) else {
    //            completion(.failure(APIError.invalidResponse))
    //            return
    //        }
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            guard let data = data, error == nil else {
    //                completion(.failure(APIError.networkError))
    //                return
    //            }
    //            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
    //                completion(.failure(APIError.invalidResponse))
    //                return
    //            }
    //            // Parse JSON using SwiftyJSON
    //            do {
    //                let json = try JSON(data: data)
    //                guard let forecastList = ForecastResponse(json: json) else {
    //                    completion(.failure(APIError.jsonParsingError))
    //                    return
    //                }
    //                completion(.success(forecastList))
    //            } catch {
    //                completion(.failure(APIError.jsonParsingError))
    //            }
    //        }.resume()
    //    }
    
    static func fetchData(from url: URL, completion: @escaping (JSON?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(nil, APIError.invalidResponse)
                return
            }
            
            let json = try? JSON(data: data)
            completion(json, nil)
        }.resume()
    }
    
    static func getCurrentWeather(lat: String, lon: String,
                                  completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let currentWeatherUrlStr = String(format: Constant.URL.getCurrentWeather, 
                                          lat, lon)
        guard let url = URL(string: currentWeatherUrlStr) else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        fetchData(from: url) { json, error in
            guard let json = json else {
                completion(.failure(error ?? APIError.networkError))
                return
            }
            guard let weatherResponse = WeatherResponse(json: json) else {
                completion(.failure(APIError.jsonParsingError))
                return
            }
            completion(.success(weatherResponse))
        }
    }
    
    static func getCurrentWeather(cityName: String, 
                                  completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let currentWeatherUrlStr = String(format: Constant.URL.getCurrentWeatherForCity, 
                                          cityName)
        guard let url = URL(string: currentWeatherUrlStr) else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        fetchData(from: url) { json, error in
            guard let json = json else {
                completion(.failure(error ?? APIError.networkError))
                return
            }
            guard let weatherResponse = WeatherResponse(json: json) else {
                completion(.failure(APIError.jsonParsingError))
                return
            }
            completion(.success(weatherResponse))
        }
    }
    
    static func getSevenDayWeatherForecast(for cityName: String, completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
        let sevenDaysWeatherForecastUrlStr = String(format: Constant.URL.getSevenDayForcast,
                                                    cityName)
        guard let url = URL(string: sevenDaysWeatherForecastUrlStr) else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        fetchData(from: url) { json, error in
            guard let json = json else {
                completion(.failure(error ?? APIError.networkError))
                return
            }
            guard let forecastResponse = ForecastResponse(json: json) else {
                completion(.failure(APIError.jsonParsingError))
                return
            }
            completion(.success(forecastResponse))
        }
    }
}
