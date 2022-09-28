//
//  UserLocationServiceMock.swift
//  EurekaTests
//
//  Created by Carlos Caraccia on 9/28/22.
//

@testable import Eureka

import Foundation
import CoreLocation

struct UserLocationServiceMock: UserLocationManagerInterface {
    
    var locationManagerDelegate: UserLocationServiceDelegate?

    var desiredAccuracy: CLLocationAccuracy = 0

    var locationToReturn:(()->CLLocation)?
    
    func requestLocation() {
         guard let location = locationToReturn?() else { return }
         locationManagerDelegate?.locationFetcher(self, didUpdateLocations: [location])
     }
    
    func requestWhenInUseAuthorization() {
        
    }

 }

