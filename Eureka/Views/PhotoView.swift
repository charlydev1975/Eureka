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
    /*
        I like to reuse my views as much as possible, this is why I pass an extra
        param to the init to show the view in the correct way depending in the use
        case.
     */
    init(photo: Photo, inSinglePhotoMode:Bool) {
        self.inSinglePhotoMode = inSinglePhotoMode
        self.photo = photo
        /*
            Below we are showing 2 different images, in case there is no data stored we are showing a no-image-icon.
            If the data used to show the image is or was corrupted ak the image could not be constructed we are showing
            the corrupted-file image.
         */
        if let photoImageData = photo.imageData {
            self.image = UIImage(data: photoImageData) ?? UIImage(imageLiteralResourceName: "corrupted-file")
        } else {
            self.image = UIImage(imageLiteralResourceName: "no-image-icon")
        }
    }
    var body: some View {
        if (inSinglePhotoMode) {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(4/3, contentMode: .fit)
                    .padding()
                Spacer()
                Text("Latitude: \(photo.latitude ?? "")")
                    .padding(5)
                Text("Longitude: \(photo.longitude ?? "")")
                    .padding(5)
            }
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
