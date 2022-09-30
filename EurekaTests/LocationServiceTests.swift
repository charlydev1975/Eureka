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
         sut.getCurrentLocation { result in
             expactation.fulfill()
             XCTAssertNotNil(result, "We expected result not to be nil but it was")
             switch result {
                 case .success(let location):
                     XCTAssertNotNil(location, "The location should not be nil but it was")
                     XCTAssertEqual(expectedCoordinate.coordinate.latitude, location.coordinate.latitude)
                 
                case .failure(let error):
                    XCTAssertNil(error)
             }
         }
         wait(for: [expactation], timeout: 0.05)
     }
     
     func test_locationService_requestsLocationAnErrorOccurs_AnErrorShouldBeReturned() {
         var cLLocationManagerMock = CLLocationManagerMock()
         let error = NSError(domain: "com.error", code: 66)
         cLLocationManagerMock.errorToReturn = error

         let sut = UserLocationService(locationManager: cLLocationManagerMock)

         let expactation = expectation(description: "Expectation that will be fulfilled if the location is returned.")

         sut.getCurrentLocation { result in
             expactation.fulfill()
             XCTAssertNotNil(result, "We expected result not to be nil but it was")
             switch result {
                 case .success(let location):
                     XCTAssertNil(location, "The location should be nil but it was")
                 
                case .failure(let newError):
                    XCTAssertNotNil(newError)
                 XCTAssertEqual((newError as NSError).domain, error.domain)
             }
         }

         wait(for: [expactation], timeout: 3.0)

     }
}
