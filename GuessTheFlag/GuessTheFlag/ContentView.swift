//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Can Önal on 24.07.22.
//

import SwiftUI

struct FlagImage: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .accessibilityLabel(labels[country, default: "Unknown flag"])
            .flagStyle()
    }
}

extension View {
    func flagStyle() -> some View {
        modifier(FlagImageModifier())
    }
}

struct FlagImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    static let totalQuestionCount = 8
    @State private var showingScoreAlert = false
    @State private var showEndGameAlert = false
    @State private var scoreAlertTitle = ""
    @State private var scoreAlertMessage = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var questionCount = 0
    @State private var allowFlagPress = true
    
    @State private var correctAnswerAnimationAmount = [0.0, 0.0, 0.0]
    @State private var wrongAnswerAnimation = false
    @State private var animateIncreaseScore = false
    @State private var animateDecreaseScore = false
        
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.62, green: 0.24, blue: 0.55), location: 0.3),
                    .init(color: Color(red: 0.36, green: 0.25, blue: 0.76), location: 0.3)],
                center: .top,
                startRadius: 200,
                endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        FlagImage(country: countries[number])
                            .rotation3DEffect(.degrees(correctAnswerAnimationAmount[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(wrongAnswerAnimation ? (number == correctAnswer ? 1 : 0.25) : 1)
                            .onTapGesture {
                                flagTapped(number)
                            }
                            .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
                                Button("Continue", action: bringNewQuestion)
                            } message: {
                                Text("\(scoreAlertMessage)\n" +
                                     "Your score is \(userScore)")
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("+100")
                    .font(.headline)
                    .foregroundColor(animateIncreaseScore ? .green : .clear)
                    .opacity(animateIncreaseScore ? 0 : 1)
                    .offset(x: 0, y: animateIncreaseScore ? -50 : 20)
                
                Text("-100")
                    .font(.headline)
                    .foregroundColor(animateDecreaseScore ? .red : .clear)
                    .opacity(animateDecreaseScore ? 0 : 1)
                    .offset(x: 0, y: animateDecreaseScore ? -50 : 20)
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert("Game finished", isPresented: $showEndGameAlert) {
            Button("Reset the game", action: resetGame)
        } message: {
            Text("Your total score is \(userScore)")
        }
    }
    
    func flagTapped(_ number : Int) {
        guard allowFlagPress else { return }
        allowFlagPress = false
        checkAnswer(number)
        questionCount += 1
    }
    
    func checkAnswer(_ number : Int){
        let nextQuestionDelay = 1.5
        let flagAnimationDuration = 1.5
        
        if number == correctAnswer {
            userScore += 100
            scoreAlertTitle = "Correct"
            scoreAlertMessage = "This is the flag of \(countries[correctAnswer])."
            withAnimation(.easeInOut(duration: flagAnimationDuration)) {
                correctAnswerAnimationAmount[number] += 360
                wrongAnswerAnimation = true
            }
            withAnimation(.linear(duration: flagAnimationDuration)){
                animateIncreaseScore = true
            }
        } else {
            userScore -= 100
            scoreAlertTitle = "Wrong"
            scoreAlertMessage = "You selected the flag of \(countries[number]).\n Answer is \(countries[correctAnswer])."
            withAnimation(.easeInOut(duration: flagAnimationDuration)) {
                wrongAnswerAnimation = true
            }
            withAnimation(.linear(duration: flagAnimationDuration)){
                animateDecreaseScore = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + nextQuestionDelay) {
            showingScoreAlert = true
        }
    }
    
    func bringNewQuestion(){
        if (!hasGameEnded()){
            countries = countries.shuffled()
            correctAnswer = Int.random(in: 0...2)
            wrongAnswerAnimation = false
            animateIncreaseScore = false
            animateDecreaseScore = false
            allowFlagPress = true
        }
    }
    
    func hasGameEnded() -> Bool {
        if(questionCount == ContentView.totalQuestionCount){
            showEndGameAlert = true
            return true
        } else { return false }
    }
    
    func resetGame(){
        questionCount = 0
        userScore = 0
        bringNewQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
