//
//  LocationViewModelTests.swift
//  EurekaTests
//
//  Created by Carlos Caraccia on 9/29/22.
//

@testable import Eureka

import XCTest
import CoreLocation

final class LocationViewModelTests: XCTestCase {
    
    
    func test_locationViewModel_requestsLocationAndNoErrorOccurs_aLocationInAStringTupleIsReturned() throws {
        // we have already arranged
        // create the exptected location
        let expectedLocation = CLLocation(latitude: 125.0, longitude: 125.0)
        
        // create and initialize location manager mock
        var cLLocationManagerMock = CLLocationManagerMock()
        cLLocationManagerMock.locationToReturn = { return expectedLocation }
        
        // create and initialize user location service
        let userLocationService = UserLocationService(locationManager: cLLocationManagerMock)
        
        // initialize the sut
        let sut = LocationViewModel(locationService: userLocationService)

        // act
        sut.retrieveLocation()
        let location = try XCTUnwrap(sut.location)
        switch location {
        case .success(let string):
            XCTAssertEqual("\(expectedLocation.coordinate.latitude)", string.latitude)
        case .failure(let error):
            XCTAssertNil(error)
        }
    }
    
    func test_locationViewModel_requestsLocationAnErrorOccurs_anErrorShouldBePassed() throws {
        // we have already arranged
        // create the exptected location
        
        // create and initialize location manager mock
        var cLLocationManagerMock = CLLocationManagerMock()
        cLLocationManagerMock.errorToReturn = NSError(domain: "com.eureka", code: 66)
        
        // create and initialize user location service
        let userLocationService = UserLocationService(locationManager: cLLocationManagerMock)
        
        // initialize the sut
        let sut = LocationViewModel(locationService: userLocationService)

        // act
        sut.retrieveLocation()
        let location = try XCTUnwrap(sut.location)
        switch location {
        case .success(let string):
            XCTAssertNil(string)
        case .failure(let error):
            XCTAssertEqual((error as NSError).domain, "com.eureka")
        }
    }
}
