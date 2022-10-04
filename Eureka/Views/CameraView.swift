//
//  CameraView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import SwiftUI

struct CameraView:UIViewControllerRepresentable {
    
    @Binding var pickedImage:UIImage?
    @Binding var isPresented:Bool
        
    static var isAvaillable:Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(cameraView: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // no - op
    }
    
}

// Coordinator communicates between the swiftui view and the view controller
class Coordinator:NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var cameraView:CameraView
    
    init(cameraView:CameraView) {
        self.cameraView = cameraView
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cameraView.pickedImage = nil
        cameraView.isPresented = false
    }
    
    // what to do when the photo was taken
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cameraView.pickedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        cameraView.isPresented = false
    }
}


