//
//  EUPhotosViewModelTests.swift
//  EUPhotosViewModelTests
//
//  Created by Carlos Caraccia on 9/21/22.
//

import XCTest
import CoreData
import Combine

@testable import Eureka

class EUPhotosViewModelTests: XCTestCase {
    
    var sut:EUPhotosViewModel!
    
    override func setUp() {
        super.setUp()
        self.sut = EUPhotosViewModel(inMemoryModel: true)
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    
    func test_EUPhotosViewModel_add1ElementsToInMemoryStore_sutPhotosArrayShouldContain1Element() {
        // lets fake the image Data
        let imageData = UIImage(imageLiteralResourceName: "no-image-icon").pngData()!
        let latitude = "a-latitude"
        let longitude = "a-longitude"
        
        sut.addPhoto(withImageData: imageData, latitude: latitude, longitude: longitude)
        XCTAssertEqual(sut.photos.count, 1, "The count of objects should be 1 but it was not")
    }
    
    func test_EUPhotosViewModel_add3ElementsToInMemoryStore_sutPhotosArrayShouldContain3Elements() {
        for _ in 0..<3 {
            let imageData = UIImage(imageLiteralResourceName: "no-image-icon").pngData()!
            let latitude = "a-latitude"
            let longitude = "a-longitude"
            sut.addPhoto(withImageData: imageData, latitude: latitude, longitude: longitude)
        }
        XCTAssertEqual(sut.photos.count, 3, "The count of objects should be 3 but it was not")
    }
    
    func test_EUPhotosViewModel_add3ElementsToStore_sutPhotosArrayShouldNotifyChanges() {
        var cancellables = Set<AnyCancellable>()
        for _ in 0..<3 {
            let imageData = UIImage(imageLiteralResourceName: "no-image-icon").pngData()!
            let latitude = "a-latitude"
            let longitude = "a-longitude"
            sut.addPhoto(withImageData: imageData, latitude: latitude, longitude: longitude)
        }
        
        let expectation = expectation(description: "When the store is filled with a value the changes should be notified")
        sut.$photos
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // full fill the expectation when the notification was sent
        waitForExpectations(timeout: 0.5)
    }
            
}
