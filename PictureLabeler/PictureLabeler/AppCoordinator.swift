//
//  AppCoordinator.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import FlowStacks
import SwiftUI

struct AppCoordinator: View {
    enum Screen {
        case galleryScreen
        case galleryDetailScreen(PictureData)
        case addLabel(UIImage, [PictureData])
    }
    
    @State private var routes: Routes<Screen> = [.root(.galleryScreen, embedInNavigationView: true)]
    
    var body: some View {
        Router($routes) { screen, _ in
            switch(screen) {
            case .galleryScreen:
                GalleryScreen(navigateToImageDetail: navigateToImageDetail, navigateToAddLabelScreen: navigateToAddLabelScreen)
            case .galleryDetailScreen(let pictureData):
                GalleryDetailScreen(pictureData: pictureData)
            case .addLabel(let uiImage, let pictureDataList):
                AddLabelScreen(uiImage: uiImage, pictureDataList: pictureDataList,goBackToRoot: goBackToRoot)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func navigateToAddLabelScreen(uiImage: UIImage, pictureDataList: [PictureData]) {
        routes.push(.addLabel(uiImage, pictureDataList))
    }
    
    private func navigateToImageDetail(pictureData: PictureData) {
        routes.push(.galleryDetailScreen(pictureData))
    }
            
    private func goBackToRoot(){
        routes.goBackToRoot()
    }
}



