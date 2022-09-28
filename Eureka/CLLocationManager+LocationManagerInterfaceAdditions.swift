//
//  CLLocationManager+LocationManagerInterfaceAdditions.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/28/22.
//

import Foundation
import CoreLocation


extension CLLocationManager: UserLocationManagerInterface {
    
    var locationManagerDelegate: UserLocationServiceDelegate? {
        get { delegate as! UserLocationServiceDelegate? }
        set { delegate = newValue as! CLLocationManagerDelegate? }
    }
}
