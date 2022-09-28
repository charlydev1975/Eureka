//
//  ContentView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var euPhotosViewModel:EUPhotosViewModel
    // TODO: I know we should create a view model and link it to the view, but no time for now.
    private var locatoinService:UserLocationService
    
    @State private var isCameraPresented = false
    
    init(euPhotosViewModel:EUPhotosViewModel, location: UserLocationService) {
        self.euPhotosViewModel = euPhotosViewModel
        self.locatoinService = location
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(euPhotosViewModel.photos) { photo in
                            NavigationLink(destination:PhotoView(photo: photo, inSinglePhotoMode: true)) {
                                PhotoView(photo: photo, inSinglePhotoMode: false)
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                NavigationLink(destination:CameraView(handleImagePicked: {image in handleImagePickedFromCamera(image)}), isActive: $isCameraPresented) {
                    Text("Take Picture")
                }
                .disabled(!CameraView.isAvaillable)
            }
        }
    }
    
    func handleImagePickedFromCamera(_ image:UIImage?) {
        isCameraPresented = false
        // if we took the pic
        if let compressedImageData = image?.jpegData(compressionQuality: 1.0) {
            locatoinService.getCurrentLocation(completion: { location in
                // if we got the location
                // then we save through the view model
                euPhotosViewModel.addPhoto(withImageData: compressedImageData,
                                           latitude: "\(location.coordinate.latitude)",
                                           longitude: "\(location.coordinate.longitude)") })
        } else {
            isCameraPresented = false
            // we should show some kind of error according to what went wrong, but we should do it before
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
        return ContentView(euPhotosViewModel: viewModel, location: UserLocationService())
    }
}
