//
//  AddBookView.swift
//  Bookworm
//
//  Created by Can Önal on 16.09.22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingErrorAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                        .disableAutocorrection(true)
                    TextField("Author's name", text: $author)
                        .disableAutocorrection(true)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                        .disableAutocorrection(true)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        
                        if(areFieldsValid()) {
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.review = review
                            newBook.date = Date.now
                            print(Date.now)
                            
                            try? moc.save()
                            dismiss()
                        } else {
                            showingErrorAlert = true
                        }
                        
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert(alertTitle, isPresented: $showingErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func areFieldsValid() -> Bool {
        if title.isEmpty {
            setAlertText(message: "Book title can't be empty")
            return false
        }
        
        if author.isEmpty {
            setAlertText(message: "Author can't be ampty")
            return false
        }
        
        if genre.isEmpty {
            setAlertText(message: "Genre must be selected")
            return false
        }
        
        return true
    }
    
    private func setAlertText(title: String = "Error", message: String) {
        alertTitle = title
        alertMessage = message
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
