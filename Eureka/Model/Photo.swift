//
//  Photo.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import Foundation
import CoreData

struct Photo:Identifiable {
    
    let id:NSManagedObjectID
    var imageData:Data?
    var latitude:String?
    var longitude:String?
    
    init(euPhoto:EUPhoto) {
        self.id = euPhoto.objectID
        self.imageData = euPhoto.imageData
        self.latitude = euPhoto.latitude
        self.longitude = euPhoto.longitude
    }
}

