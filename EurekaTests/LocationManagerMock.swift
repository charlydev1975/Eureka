//
//  LocationManagerMock.swift
//  EurekaTests
//
//  Created by Carlos Caraccia on 9/28/22.
//

@testable import Eureka

import Foundation
import CoreLocation

struct CLLocationManagerMock: CLLocationManagerInterface {
    
    var locationManagerDelegate: UserLocationServiceDelegate?

    var desiredAccuracy: CLLocationAccuracy = 0

    var locationToReturn:(()->CLLocation)?
    var errorToReturn:NSError?
    
    func requestLocation() {
         guard let location = locationToReturn?() else {
             locationManagerDelegate?.locationFetcher(self, didFailWithError: errorToReturn!)
             return
         }
         locationManagerDelegate?.locationFetcher(self, didUpdateLocations: [location])
     }
    
    func requestWhenInUseAuthorization() {
        
    }

 }

