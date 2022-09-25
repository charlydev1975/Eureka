//
//  EurekaApp.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI

@main
struct EurekaApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            let euPhotoViewModel = EUPhotosViewModel(inMemoryModel: false)
            ContentView(euPhotosViewModel: euPhotoViewModel)
                .onChange(of: scenePhase) { newValue in
                    switch newValue {
                        case .active:
                            // start receiving gps data
                            UserLocationManager.sharedManager.startGettingLocatoin()
                            break
                        case .background:
                            // stop gps data
                            UserLocationManager.sharedManager.stopGettingLocation()
                            break
                        case .inactive:
                            // stop gps data
                            UserLocationManager.sharedManager.startGettingLocatoin()
                            break
                        default:
                            break
                    }
                }
        }
    }
}
