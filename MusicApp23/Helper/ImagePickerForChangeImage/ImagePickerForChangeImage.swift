//
//  ImagePicker.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import SwiftUI
import UIKit

struct ImagePickerForChangeImage: UIViewControllerRepresentable {
    
    // MARK: - Properties
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var onImageSelected: (UIImage) -> Void
    
    // MARK: - Class Coordinator
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        // MARK: Properties
        var parent: ImagePickerForChangeImage
        
        // MARK: Initializer
        init(parent: ImagePickerForChangeImage) {
            self.parent = parent
        }
        
        // MARK: Methods
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
                parent.onImageSelected(uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerForChangeImage>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerForChangeImage>) {
        /// Optional: you can add UI update processing for the selected image
    }
}
