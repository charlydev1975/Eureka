//
//  EurekaApp.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI

@main
struct EurekaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
