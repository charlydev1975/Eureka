//
//  PhotoView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import SwiftUI
import CoreData

struct PhotoView: View {
    
    let image:UIImage
    // TODO: add a property to be initialized to modify the view regarding it is in full screen or if it is shown to be picked.
    init(photo: Photo) {
        if let photoImageData = photo.imageData {
            self.image = UIImage(data: photoImageData) ?? UIImage(imageLiteralResourceName: "no-image-icon")
        } else {
            self.image = UIImage(imageLiteralResourceName: "no-image-icon")
        }
    }
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(4/3, contentMode: .fit)
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo(euPhoto: EUPhoto(context: PersistenceController.init(inMemory: true).container.viewContext)))
    }
}
