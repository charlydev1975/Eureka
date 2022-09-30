//
//  ContentView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject private var euPhotosViewModel:EUPhotosViewModel
    private var locationViewModel:LocationViewModel
    
    @State private var isCameraPresented = false
    @State private var isErrorPresented = false
    
    @State private var locationError:Error?
    
    init(euPhotosViewModel:EUPhotosViewModel, locationViewModel: LocationViewModel) {
        self.euPhotosViewModel = euPhotosViewModel
        self.locationViewModel = locationViewModel
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
                NavigationLink(destination:CameraView(handleImagePicked: {image in handleImagePickedFromCamera(image)}).onAppear{self.locationViewModel.retrieveLocation()},
                               isActive: $isCameraPresented) {
                    Text("Take Picture")
                }
                .disabled(!CameraView.isAvaillable)
            }
            .alert("Error: \(locationError?.localizedDescription ?? "")", isPresented: $isErrorPresented) {
                Button("Dismiss") {
                    isErrorPresented = false
                }
            }
        }
    }
    
    // this should go somewhere else, but as it is a view we will leave it here
    func handleImagePickedFromCamera(_ image:UIImage?) {
        isCameraPresented = false
        // if we took the pic
        if let imageData = image?.jpegData(compressionQuality: 1.0) {
            // if we got a valid location
            guard let location = locationViewModel.location else { return } // we are not handling this error, we should
                switch location {
                case .success(let stringedLocation):
                    euPhotosViewModel.addPhoto(withImageData: imageData,
                                               latitude: stringedLocation.latitude,
                                               longitude: stringedLocation.longitude)
                case .failure(let error):
                    // dispaly error with @state
                    self.locationError = error as NSError
                    self.isErrorPresented = true
                    break
                }
        } else {
            isCameraPresented = false
            // present problem in converting image error
        }
    }
}


// MARK: - ContentView Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let euPhotoViewModel = EUPhotosViewModel(inMemoryModel: true)
        let locationViewModel = LocationViewModel(locationService: UserLocationService())
        for _ in 0..<3 {
            let imageData = UIImage(imageLiteralResourceName: "no-image-icon").pngData()!
            let latitude = "a-latitude"
            let longitude = "a-longitude"
            euPhotoViewModel.addPhoto(withImageData: imageData, latitude: latitude, longitude: longitude)
        }
        return ContentView(euPhotosViewModel: euPhotoViewModel, locationViewModel: locationViewModel)
    }
}
