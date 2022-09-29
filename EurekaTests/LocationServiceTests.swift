//
//  LocationServiceTests.swift
//  EurekaTests
//
//  Created by Carlos Caraccia on 9/28/22.
//

import XCTest
import CoreLocation

@testable import Eureka

 final class LocationServiceTests: XCTestCase {

     func test_locationSerive_requestedLocationIsLatitude125Longitude125_ShouldReturnLatitude125Longitude125() {
        
        var cLLocationManagerMock = CLLocationManagerMock()

         cLLocationManagerMock.locationToReturn = { return CLLocation(latitude: 125.0, longitude: 125.0) }
         
        let sut = UserLocationService(locationManager: cLLocationManagerMock)

        let expectedCoordinate = CLLocation(latitude: 125.0, longitude: 125.0)
        let expactation = expectation(description: "Expectation that will be fulfilled if the location is returned.")

        sut.getCurrentLocation { (location) in
            expactation.fulfill()
            XCTAssertEqual(location.coordinate.latitude, expectedCoordinate.coordinate.latitude, "The locations latitude should be the same as the desired one, but it was not")
            XCTAssertEqual(location.coordinate.longitude, expectedCoordinate.coordinate.longitude, "The locations longitude should be the same as the desired one, but it was not")
        }
        
        wait(for: [expactation], timeout: 3.0)
         
     }
}
