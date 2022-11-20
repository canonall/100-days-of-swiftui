//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Can Önal on 30.07.22.
//

import SwiftUI

enum MoveType: String{
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct MoveView: View {
    var symbol: String
    var label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(symbol)
                .font(.system(size: 65))
                
            Text(label)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var round = 1
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var showResultAlert = false
    @State private var showEndGameAlert = false
    @State private var resultAlertTitle = ""
    
    let maxRoundCount = 10
    let moveList: [(moveType: MoveType, symbol: String)] = [
        (MoveType.rock, "✊"),
        (MoveType.paper, "✋"),
        (MoveType.scissors, "✌️")
    ]
    
    let winningMoveList: [MoveType] = [MoveType.paper, MoveType.scissors, MoveType.rock]
    let losingMoveList: [MoveType] = [MoveType.scissors, MoveType.rock, MoveType.paper]
    
    var correctAnswer: MoveType {
        if(shouldWin) {
            return winningMoveList[appMove]
        } else {
            return losingMoveList[appMove]
        }
    }
    
    var shouldWinText: String {
        return shouldWin ? "Win" : "Lose"
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                      stops: [
                        .init(color: Color(red: 0.99, green: 0.69, blue: 0.1), location: 0.3),
                        .init(color: .blue, location: 0.3)],
                      center: .top,
                      startRadius: 20,
                      endRadius: 700)
                  .ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                Spacer()
                
                Section {
                    Text("Score: \(score)")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.black)
                    
                    Text("Round: \(round)/\(maxRoundCount)")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack {
                    Text("App plays")
                        .padding()
                        .font(.callout)
                        .foregroundColor(.black)
                    
                    Text("\(moveList[appMove].symbol) \(shouldWinText)")
                        .foregroundColor(shouldWin ? .green : .red)
                        .font(.system(size: 45))
                    
                    
                    Text("Make your move!")
                        .padding()
                        .font(.callout)
                        .foregroundColor(.black)
                }
                
                
                HStack {
                    ForEach(0..<3) { number in
                        Button{
                            checkMove(selectedMove: moveList[number].moveType)
                        } label: {
                            MoveView(symbol: moveList[number].symbol, label: moveList[number].moveType.rawValue)
                        }
                        .alert(resultAlertTitle, isPresented: $showResultAlert) {
                            Button("Continue", action: checkEndGame)
                        } message: {
                            Text("Your score is \(score)")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert("Game Finished", isPresented: $showEndGameAlert) {
            Button("Reset the game", action: resetGame)
        } message: {
            Text("Your total score is \(score)")
        }
    }
    
    func checkMove(selectedMove: MoveType){
        if(selectedMove == correctAnswer){
            score += 1
            resultAlertTitle = "Correct!"
        } else {
            score -= 1
            resultAlertTitle = "Wrong!"
        }
        showResultAlert = true
    }
    
    func bringNewRound() {
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func checkEndGame(){
        if(round == maxRoundCount){
            showEndGameAlert = true
        } else {
            round += 1
            bringNewRound()
        }
    }
    
    func resetGame(){
        round = 1
        score = 0
        bringNewRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
