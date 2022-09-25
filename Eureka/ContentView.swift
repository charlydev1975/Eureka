//
//  ContentView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var euPhotosViewModel:EUPhotosViewModel
    @ObservedObject private var userLocationManager = UserLocationManager.sharedManager
    
    @State private var isCameraPresented = false
    @State private var isPhotoPresented = false
    
    init(euPhotosViewModel:EUPhotosViewModel) {
        self.euPhotosViewModel = euPhotosViewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(euPhotosViewModel.photos) { photo in
                            NavigationLink(destination:PhotoView(photo: photo), isActive: $isPhotoPresented) {
                                PhotoView(photo: photo)
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                NavigationLink(destination:CameraView(handleImagePicked: {image in handleImagePickedFromCamera(image)}),
                               isActive: $isCameraPresented) {
                    Text("Take Picture")
                }
                .disabled(!userLocationManager.isCurrentLocationAvaillable)
            }
        }
    }
    
    func handleImagePickedFromCamera(_ image:UIImage?) {
        if let compressedImageData = image?.jpegData(compressionQuality: 1.0) {
            if let tuple = userLocationManager.currentLocation {
                euPhotosViewModel.addPhoto(withImageData: compressedImageData, latitude: tuple.latitude, longitude: tuple.longitude)
            }
        }
    }
}


// MARK: Content View Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EUPhotosViewModel(inMemoryModel: true)
        for _ in 0..<3 {
            let imageData = UIImage(imageLiteralResourceName: "no-image-icon").pngData()!
            let latitude = "a-latitude"
            let longitude = "a-longitude"
            viewModel.addPhoto(withImageData: imageData, latitude: latitude, longitude: longitude)
        }
        return ContentView(euPhotosViewModel: viewModel)
    }
}
