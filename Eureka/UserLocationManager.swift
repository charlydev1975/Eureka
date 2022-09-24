//
//  UserLocationManager.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import Foundation
import MapKit


class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedManager = UserLocationManager()
    
    private var locationManager = CLLocationManager()
    
    var isCurrentLocationAvaillable = false
    
    var currentLocation: CLLocation? {
        didSet {
            self.isCurrentLocationAvaillable = true
        }
    }
    
    private override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = 10 // kcllocationacuracybest
        self.locationManager.distanceFilter = 10 // kcll
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startGettingLocatoin() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopGettingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: CLLocationManagerDelegate
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocation = location
        }
    }
}
