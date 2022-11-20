//
//  GalleryScreen.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import SwiftUI

struct GalleryScreen: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showingImagePicker = false
    @State private var showingLabelSheet = false
    
    let navigateToImageDetail: (PictureData) -> Void
    let navigateToAddLabelScreen: (UIImage, [PictureData]) -> Void
    
    var body: some View {
        VStack {
            viewModel.image?
                .resizable()
                .scaledToFit()
            List {
                ForEach(viewModel.pictureDataList) { pictureData in
                    GalleryItem(pictureData: pictureData) { selectedPictureData in
                        navigateToImageDetail(selectedPictureData)
                    }
                }
                .onDelete { viewModel.removeItems(at: $0) }
            }
        }
        .navigationTitle("PictureLabeler")
        .onChange(of: viewModel.inputImage) { newValue in
            if let selectedImage = newValue {
                navigateToAddLabelScreen(selectedImage, viewModel.pictureDataList)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $viewModel.inputImage)
        }
        .onAppear{
            viewModel.setData()
        }
    }
}

struct GalleryScreen_Previews: PreviewProvider {
    static var previews: some View {
        GalleryScreen(navigateToImageDetail: { _ in }, navigateToAddLabelScreen: {_, _ in })
    }
}
