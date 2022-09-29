//
//  EurekaApp.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI

@main
struct EurekaApp: App {
    
    var body: some Scene {
        WindowGroup {
            let euPhotoViewModel = EUPhotosViewModel(inMemoryModel: false)
            let locationService = UserLocationService()
            let locationViewModel = LocationViewModel(locationService: locationService)
            ContentView(euPhotosViewModel: euPhotoViewModel, locationViewModel: locationViewModel)
        }
    }
}
