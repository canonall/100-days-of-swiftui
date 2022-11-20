//
//  AddLabelScreen.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import SwiftUI

struct AddLabelScreen: View {
    @StateObject var viewModel = ViewModel()
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    @State private var showMapScreen = false
    
    let uiImage: UIImage
    let image: Image
    let pictureDataList: [PictureData]
    let goBackToRoot: () -> Void
    
    init(uiImage: UIImage, pictureDataList: [PictureData], goBackToRoot: @escaping () -> Void) {
        self.uiImage = uiImage
        self.image = Image(uiImage: uiImage)
        self.pictureDataList = pictureDataList
        self.goBackToRoot = goBackToRoot
    }
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
            
            Text(viewModel.location?.name ?? "No location selected for this picture")
                .foregroundColor(.secondary)
                .italic()
                .padding()
            
            Form {
                TextField("Enter a label", text: $viewModel.label)
                Button("Add location") {
                    showMapScreen = true
                }
            }
        }
        .alert("Error", isPresented: $showingErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save"){
                    if(viewModel.label.isEmpty) {
                        errorMessage = "Please enter a label!"
                        showingErrorAlert = true
                    } else if(viewModel.location == nil) {
                        errorMessage = "Please select a location!"
                        showingErrorAlert = true
                    } else {
                        viewModel.saveToDirectory(uiImage: uiImage)
                        goBackToRoot()
                    }
                }
            }
        }
        .sheet(isPresented: $showMapScreen, content: {
            MapScreen(location: $viewModel.location)
        })
        .onAppear {
            viewModel.setPictureDataList(pictureDataList: pictureDataList)
        }
    }
}
