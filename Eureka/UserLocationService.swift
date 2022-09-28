//
//  UserLocationService.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/28/22.
//

import Foundation
import CoreLocation


protocol UserLocationServiceDelegate: AnyObject {
    func locationFetcher(_ fetcher: UserLocationManagerInterface, didUpdateLocations locations: [CLLocation])
}

class UserLocationService: NSObject, CLLocationManagerDelegate, UserLocationServiceDelegate {
    
    var locationManager: UserLocationManagerInterface
    
    var currentLocation:((CLLocation) -> ())?
    
    init(locationManager: UserLocationManagerInterface = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.locationManagerDelegate = self
    }
    
    func getCurrentLocation(completion:@escaping (CLLocation) -> ()) {
        
        currentLocation = { location in completion(location) }
        self.locationManager.requestLocation()
        self.locationManager.requestWhenInUseAuthorization()
        

    }
    
    // MARK: - Location manager delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        self.locationFetcher(manager, didUpdateLocations: locations)
    }
    
    // we should implement this method other wise we'll get an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    // MARK: - Location service delegate
    
    func locationFetcher(_ manager: UserLocationManagerInterface, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocation?(location)
        self.currentLocation = nil
    }

}

