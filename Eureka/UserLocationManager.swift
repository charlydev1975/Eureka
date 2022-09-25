//
//  UserLocationManager.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import Foundation
import CoreLocation

class UserLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    static let sharedManager = UserLocationManager()
    
    private var locationManager = CLLocationManager()
    
    @Published var isCurrentLocationAvaillable = false
    @Published var currentLocation: (latitude:String, longitude:String)?
    
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
            DispatchQueue.main.async {
                self.isCurrentLocationAvaillable = true
                let latitude = "\(location.coordinate.latitude)"
                let longitude = "\(location.coordinate.longitude)"
                self.currentLocation = (latitude, longitude)
            }
        }
    }
}
