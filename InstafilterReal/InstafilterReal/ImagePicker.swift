//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Can Önal on 30.09.22.
//

import PhotosUI
import SwiftUI

//watch day 64 to repeat
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    //has to be a class but necessarily a nested class
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator //report actions to coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        // talks between SwiftUI and UIKit
        Coordinator(self)
    }
    
    // typealias UIViewControllerType = PHPickerViewController -> remove it after overriding the methods
}


