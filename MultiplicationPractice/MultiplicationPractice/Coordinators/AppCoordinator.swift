//
//  AppCoordinator.swift
//  MultiplicationPractice
//
//  Created by Can Önal on 13.08.22.
//

import SwiftUI
import FlowStacks

struct AppCoordinator: View {
    
    enum Screen {
        case home
        case game(Int, Int)
    }
    
    @State private var routes: Routes<Screen> = [.root(.home)]
    
    var body: some View {
        Router($routes) { screen, _ in
            switch(screen) {
            case .home:
                HomeScreen(onGameTapped: navigateToGameScreen(questionCount:tableCount:))
            case .game(let questionCount, let tableCount):
                GameScreen(onBack: goBack, questionCount: questionCount , tableCount: tableCount, questions: Questions(questionCount: questionCount, tableCount: tableCount).questions)
            }
        }
    }
    
    private func navigateToGameScreen(questionCount: Int, tableCount: Int) {
        routes.presentCover(.game(questionCount,tableCount))
    }
    
    private func goBack() {
        routes.goBack()
    }
}

struct AppCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinator()
    }
}
