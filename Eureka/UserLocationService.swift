//
//  UserLocationService.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/28/22.
//

import Foundation
import CoreLocation

protocol UserLocationServiceDelegate: AnyObject {
    func locationFetcher(_ fetcher: CLLocationManagerInterface, didUpdateLocations locations: [CLLocation])
    func locationFetcher(_ fetcher: CLLocationManagerInterface, didFailWithError error: Error)
}

class UserLocationService: NSObject, CLLocationManagerDelegate, UserLocationServiceDelegate {
    
    var locationManager: CLLocationManagerInterface
    
    var currentLocation:((Result<CLLocation,Error>) -> ())?
    
    init(locationManager: CLLocationManagerInterface = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.locationManagerDelegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation(completion:@escaping (Result<CLLocation,Error>) -> ()) {
        currentLocation = { location in completion(location) }
        self.locationManager.requestLocation()
    }
    
    // MARK: - Location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        self.locationFetcher(manager, didUpdateLocations: locations)
    }
    
    // we should implement this method other wise we'll get an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationFetcher(manager, didFailWithError: error)
    }
    
    // MARK: - Location service delegate
    
    func locationFetcher(_ manager: CLLocationManagerInterface, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return } // we should add an error case in this return
        self.currentLocation?(.success(location))
        self.currentLocation = nil
    }
    
    func locationFetcher(_ fetcher: CLLocationManagerInterface, didFailWithError error: Error) {
        self.currentLocation?(.failure(error))
    }
}

