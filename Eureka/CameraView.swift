//
//  CameraView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import SwiftUI

struct CameraView:UIViewControllerRepresentable {
    
    // communicate with other view
    var handleImagePicked:(UIImage?) -> ()
    
    // show if camera is available
    static var isAvaillable:Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    // create interface
    func makeCoordinator() -> Coordinator {
        Coordinator(handleImagePicked: handleImagePicked)
    }
    
    // perform actions
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
    
    // interface
    class Coordinator:NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        // communicate with interface
        var handleImagePicked:(UIImage?) -> ()
        
        init(handleImagePicked:@escaping(UIImage?) -> ()) {
            self.handleImagePicked = handleImagePicked
        }
        
        // pass a nil image if the user picked no image, if the users cancels nothing will happen since we don't
        // do any action with a nil image
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            handleImagePicked(nil)
        }
        
        // what to do when the photo was taken
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            handleImagePicked((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }
}

