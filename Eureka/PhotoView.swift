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
    let inSinglePhotoMode:Bool
    let photo:Photo
    
    
    init(photo: Photo, inSinglePhotoMode:Bool) {
        self.inSinglePhotoMode = inSinglePhotoMode
        self.photo = photo
        if let photoImageData = photo.imageData {
            self.image = UIImage(data: photoImageData) ?? UIImage(imageLiteralResourceName: "no-image-icon")
        } else {
            self.image = UIImage(imageLiteralResourceName: "no-image-icon")
        }
    }
    var body: some View {
        if (inSinglePhotoMode) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(4/3, contentMode: .fit)
                .padding()
            Spacer()
            Text("Latitude: \(photo.latitude ?? "")")
            Text("Longitude: \(photo.longitude ?? "")")
        } else {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(4/3, contentMode: .fit)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo(euPhoto: EUPhoto(context: PersistenceController.init(inMemory: true).container.viewContext)), inSinglePhotoMode: true)
    }
}
