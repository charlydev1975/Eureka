//
//  ContentView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI



struct ContentView: View {
    
    // view models
    @ObservedObject private var euPhotosViewModel:EUPhotosViewModel
    private var locationViewModel:LocationViewModel
    
    // presentation vars
    @State private var isCameraPresented = false
    @State private var isErrorPresented = false
    
    // passed objects
    @State private var pickedImage:UIImage?
    @State private var locationError:NSError?
    
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
                NavigationLink(destination:CameraView(pickedImage: $pickedImage,
                                                      isPresented: $isCameraPresented)
                                                .onAppear{self.locationViewModel.retrieveLocation()},
                               isActive: $isCameraPresented) {
                    Text("Take Picture")
                        .onTapGesture {
                            isCameraPresented = true
                        }
                }
                .disabled(!CameraView.isAvaillable)
            }
            .alert("Error domain: \(locationError?.domain ?? ""), code: \(locationError?.code ?? 00) ", isPresented: $isErrorPresented) {
                Button("Dismiss") {
                    isErrorPresented = false
                }
            }
            .onChange(of: pickedImage) { newValue in
                handleImagePickedFromCamera(newValue)
            }
        }
    }
    
    // this should go somewhere else, but as it is a view we will leave it here
    func handleImagePickedFromCamera(_ image:UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 1.0) {
            guard let location = locationViewModel.location else { return } // we are not handling this error, we should
                switch location {
                case .success(let stringedLocation):
                    euPhotosViewModel.addPhoto(withImageData: imageData,
                                               latitude: stringedLocation.latitude,
                                               longitude: stringedLocation.longitude)
                    // we can remove this in case of a real image cause the time stamp will differ
                    pickedImage = nil
                case .failure(let error):
                    self.locationError = error as NSError
                    self.isErrorPresented = true
                    // we can remove this in case of a real image cause the time stamp will differ
                    pickedImage = nil
                }
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
