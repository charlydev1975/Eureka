//
//  LocationViewModel.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/29/22.
//

import Foundation

class LocationViewModel:NSObject {
    
    private let locationService:UserLocationService
    var location:Result<(latitude:String,longitude:String),Error>?
    
    init(locationService:UserLocationService) {
        self.locationService = locationService
    }
    
    
    // MARK: - Intents
    
    func retrieveLocation() {
        locationService.getCurrentLocation { position in
            switch position {
            case .success(let location):
                let latitude = "\(location.coordinate.latitude)"
                let longitude = "\(location.coordinate.longitude)"
                self.location = .success((latitude:latitude, longitude:longitude))
            case .failure(let error):
                self.location = .failure(error)
            }
        }
    }
}


