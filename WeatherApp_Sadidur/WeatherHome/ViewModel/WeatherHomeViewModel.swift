//
//  WeatherHomeViewModel.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import Foundation
import CoreLocation

protocol WeatherHomeVMViewDelegate: AnyObject {
    func didFetchWeatherSuccessfully(with weather: WeatherData)
    func didFailToFetchWeather(with error: Error)
    
    func didFetchforecastSuccessfully()
    func didFailToFetchForecast(with error: Error)
}

protocol WeatherHomeVMP {
    var delegate: WeatherHomeVMViewDelegate? { get set }
    var forecastResponse: ForecastResponse? {get}
    var forecastList: [ForecastModel]? { get set }
    
    func fetchWeather(for cityName: String)
    func onViewLoaded()
}

class WeatherHomeViewModel: WeatherHomeVMP {
    weak var delegate: WeatherHomeVMViewDelegate?
    var forecastResponse: ForecastResponse?
    var forecastList: [ForecastModel]?
    
    func onViewLoaded() {
        fetchCurrentLocation()
        //fetchWeather()
    }
    
    func fetchCurrentLocation() {
        LocationService.shared.delegate = self
        LocationService.shared.startUpdatingLocation()
    }
    
    func fetchWeather(for cityName: String) {
        WeatherAPIService.getCurrentWeather(cityName: cityName) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                // Access data from the weatherResponse object
                guard let weatherData = weatherResponse.data?.first else {
                    return
                }
                self?.fetchForecastList(for: cityName)
                self?.delegate?.didFetchWeatherSuccessfully(with: weatherData)
            case .failure(let error):
                self?.delegate?.didFailToFetchWeather(with: error)
            }
        }
    }
    
    func fetchForecastList(for cityName: String) {
        WeatherAPIService.getSevenDayWeatherForecast(for: cityName.lowercased()) { [weak self] result in
            switch result {
            case .success(let forecastResponse):
                self?.forecastList = forecastResponse.list
                self?.delegate?.didFetchforecastSuccessfully()
            case .failure(let error):
                self?.delegate?.didFailToFetchForecast(with: error)
            }
        }
    }
}

extension WeatherHomeViewModel: LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation) {   
        let latitude: String = Double(currentLocation.coordinate.latitude).doubleToString
        let longitude: String = Double(currentLocation.coordinate.longitude).doubleToString
        WeatherAPIService.getCurrentWeather(lat: latitude,
                                            lon: longitude) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                // Access data from the weatherResponse object
                guard let weatherData = weatherResponse.data?.first else {
                    return
                }
                self?.fetchForecastList(for: weatherData.cityName ?? "")
                self?.delegate?.didFetchWeatherSuccessfully(with: weatherData)
            case .failure(let error):
                self?.delegate?.didFailToFetchWeather(with: error)
            }
        }
    }

    func tracingLocationDidFailWithError(error: Error) {
        // Handle the error
        delegate?.didFailToFetchWeather(with: error)
    }
}
