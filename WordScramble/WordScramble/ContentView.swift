//
//  ContentView.swift
//  WordScramble
//
//  Created by Can Önal on 04.08.22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showErrorAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .onSubmit(addNewWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
                
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("Score: \(score)")
                        .font(.title2)
                    
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Change word", action: startGame)
                }
            }
            .alert(errorTitle, isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 3 else {
            wordError(title: "Word is too short", message: "Word must be more than 3 letters!")
            return
            
        }
        
        guard answer != rootWord else {
            wordError(title: "Word can't be the same with root word", message: "You can be more creative!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            increaseScore(word: answer)
        }
        newWord = ""
    }
    
    func increaseScore(word: String){
        score += (10 * word.count)
    }
    
    func startGame() {
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                score = 0
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showErrorAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
