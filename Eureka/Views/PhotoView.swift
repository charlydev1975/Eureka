//
//  PhotoView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import SwiftUI
import CoreData

struct PhotoView: View {
    
    let inSinglePhotoMode:Bool
    let photo:EUPhoto
    /*
        I like to reuse my views as much as possible, this is why I pass an extra
        param to the init to show the view in the correct way depending in the use
        case.
     */
    init(photo: EUPhoto, inSinglePhotoMode:Bool) {
        self.inSinglePhotoMode = inSinglePhotoMode
        self.photo = photo
    }
    var body: some View {
        if (inSinglePhotoMode) {
            VStack {
                Image(uiImage: photo.photoImage)
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
            Image(uiImage: photo.photoImage)
                .resizable()
                .aspectRatio(4/3, contentMode: .fit)
        }
    }
}


// MARK: - ContentView Previews

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: EUPhoto(context: PersistenceController.init(inMemory: true).container.viewContext), inSinglePhotoMode: true)
    }
}
