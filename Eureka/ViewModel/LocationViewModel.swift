//
//  LocationViewModel.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/29/22.
//

import Foundation

class LocationViewModel:NSObject, ObservableObject {
    
    private let locationService:UserLocationService
    @Published var location:(latitude:String, longitude:String)?
    
    init(locationService:UserLocationService) {
        self.locationService = locationService
    }
    
    func retrieveLocation() {
        locationService.getCurrentLocation { position in
            let latitude = "\(position.coordinate.latitude)"
            let longitude = "\(position.coordinate.longitude)"
            self.location = (latitude, longitude)
        }
    }
}


