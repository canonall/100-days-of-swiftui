//
//  GameScreen.swift
//  MultiplicationPractice
//
//  Created by Can Önal on 13.08.22.
//

import Combine
import SwiftUI

struct GameScreen: View {
    
    @State private var round = 0
    @State private var userAnswer: Double?
    @State private var message = ""
    @State private var animateResultMessage = false
    @State private var isGameFinished = false
    @State private var isAnswerCorrect = false
    @FocusState private var keyboardFocus: Bool
    
    let onBack: () -> Void
    let questionCount: Int
    let tableCount: Int
    let questions: [Question]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if(!isGameFinished) {
                    GameView()
                } else {
                    GameEndView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Question: \(isGameFinished ? 0 : round + 1)/\(questionCount)")
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Return to settings", action: onBack)
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Submit"){
                        print("\(questions.count)")
                        checkAnswer()
                        keyboardFocus = false
                    }
                }
            }
        }
    }
    
    private func GameView() -> some View {
        VStack {
            QuestionView()
            AnswerView()
            Text(message)
                .padding()
                .font(.headline)
                .foregroundColor(animateResultMessage ? (isAnswerCorrect ? .green : .red) : .clear)
                .opacity(animateResultMessage ? 0 : 1)
                .offset(x: 0, y: animateResultMessage ? -50 : 20)
            Spacer()
            Spacer()
        }
    }
    
    private func GameEndView() -> some View {
        VStack {
            Text("Game Finished")
                .font(.largeTitle)
        }
    }
    
    private func QuestionView() -> some View {
        Text("\(questions[round].text)")
            .font(.title)
    }
    
    private func AnswerView() -> some View {
        VStack(alignment: .center) {
            
            TextField("Your answer", value: $userAnswer, format: .number)
                .keyboardType(.numberPad)
                .focused($keyboardFocus)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private func checkAnswer() {
        let animationDuration = 2.0
        
        if userAnswer == questions[round].answer {
            isAnswerCorrect = true
            message = "Correct! 🥳"
        } else {
            isAnswerCorrect = false
            message = "Wrong 😭"
        }
        
        withAnimation(.linear(duration: animationDuration)) {
            animateResultMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            checkGameEnd()
        }
    }
    
    private func checkGameEnd() {
        round += 1
        if(round == questionCount) {
            isGameFinished = true
        } else {
            bringNewQuestion()
        }
    }
    
    private func bringNewQuestion() {
        animateResultMessage = false
        userAnswer = nil 
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(onBack: {}, questionCount: 5, tableCount: 5, questions: Questions(questionCount: 5,tableCount: 5).questions)
    }
}
