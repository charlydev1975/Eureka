//
//  UserLocationManagerInterface.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/28/22.
//

import Foundation
import CoreLocation

protocol UserLocationManagerInterface {
    
    var locationManagerDelegate: UserLocationServiceDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    func requestLocation()
    func requestWhenInUseAuthorization()
}

