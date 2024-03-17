//
//  LocationManager.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

// source: https://gist.github.com/Abedalkareem/409d3cbddd63a70cfed81a266487af8d (got idea from this gist)

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    static let shared = LocationService()

    private var locationManager: CLLocationManager?
    private var lastLocation: CLLocation?
    weak var delegate: LocationServiceDelegate?

    override private init() {
        super.init()

        self.locationManager = CLLocationManager()

        guard let locationManager = self.locationManager else {
            return
        }

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.delegate = self
    }

    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }

    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }

        // Singleton for getting the last location
        self.lastLocation = location

        // Use for real-time update location
        updateLocation(currentLocation: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        // Do on error
        updateLocationDidFailWithError(error: error)
    }

    // Private functions
    private func updateLocation(currentLocation: CLLocation) {

        guard let delegate = self.delegate else {
            return
        }

        delegate.tracingLocation(currentLocation: currentLocation)
    }

    private func updateLocationDidFailWithError(error: Error) {

        guard let delegate = self.delegate else {
            return
        }

        delegate.tracingLocationDidFailWithError(error: error)
    }
}

