//
//  LocationViewModelTests.swift
//  EurekaTests
//
//  Created by Carlos Caraccia on 9/29/22.
//

@testable import Eureka

import XCTest
import CoreLocation
import Combine

final class LocationViewModelTests: XCTestCase {
    
    var sut:LocationViewModel!
    var expectedLocation:CLLocation!

    override func setUp() {
        // create the exptected location
        expectedLocation = CLLocation(latitude: 125.0, longitude: 125.0)
        
        // create and initialize location manager mock
        var cLLocationManagerMock = CLLocationManagerMock()
        cLLocationManagerMock.locationToReturn = { return self.expectedLocation }
        
        // create and initialize user location service
        let userLocationService = UserLocationService(locationManager: cLLocationManagerMock)
        
        // initialize the sut
        sut = LocationViewModel(locationService: userLocationService)
        
    }
    
    override func tearDown() {
        sut = nil
        expectedLocation = nil
        super.tearDown()
    }
    
    func test_locationViewModel_requestsLocationAndNoErrorOccurs_aLocationInAStringTupleIsReturned() {
        // we have already arranged
        // act
        sut.retrieveLocation()
        // assert
        XCTAssertEqual(sut.location?.latitude, "\(expectedLocation.coordinate.latitude)")
    }
    
    func test_locationViewModel_requestLocationAndNoErrorOccurs_aValueShouldBePublished(){
        // arrange
        let expectation = expectation(description: "expect to receive a value")
        var cancellables = Set<AnyCancellable>()
        // act
        sut.retrieveLocation()
        // assert
        sut.$location
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
    }

    func test_locationViewModel_requestLocationAndNoErrorOccurs_aStringTupleShouldBePublished(){
        // arrange
        let expectation = expectation(description: "expect to receive a value")
        let expectedStringTuple = ("125.0","125.0")
        var cancellables = Set<AnyCancellable>()
        // act
        sut.retrieveLocation()
        // assert
        sut.$location
            .sink { location in
                expectation.fulfill()
                XCTAssertEqual(expectedStringTuple.0, location?.latitude)
                XCTAssertEqual(expectedStringTuple.1, location?.longitude)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
    }

}
