//
//  EditCardsScreen.swift
//  Flashzilla
//
//  Created by Can Önal on 07.11.22.
//

import SwiftUI

struct EditCardsScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var cardViewModel: CardViewModel
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(cardViewModel.cards, id: \.id) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear {
                cardViewModel.loadData()
            }
        }
    }
    
    func done() {
        dismiss()
    }
    
     func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
         let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
         cardViewModel.cards.insert(card, at: 0)
        cardViewModel.saveData()
        clearTextFields()
    }
    
     func removeCards(at offset: IndexSet) {
         cardViewModel.cards.remove(atOffsets: offset)
        cardViewModel.saveData()
    }
    
    func clearTextFields() {
        newPrompt = ""
        newAnswer = ""
    }
}

struct EditCardsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsScreen(cardViewModel: CardViewModel())
    }
}
