//
//  Question.swift
//  MultiplicationPractice
//
//  Created by Can Önal on 13.08.22.
//

import Foundation

struct Question {
    let text: String
    let answer: Double
}

struct Questions {
    var questions = [Question]()
    
    init(questionCount: Int, tableCount: Int){
        questions = generateQuestions(questionCount: questionCount, tableCount: tableCount)
    }
    
    private func generateQuestions(questionCount: Int, tableCount: Int) -> [Question] {
        var questions = [Question]()
       
        for _ in 1...questionCount {
            let firstMultiplier = Int.random(in: 1...tableCount)
            let secondMultiplier = Int.random(in: 1...10)
            let answer = firstMultiplier * secondMultiplier
            questions.append(Question(text: "\(firstMultiplier) x \(secondMultiplier) = ?", answer: Double(answer)))
        }
        
        return questions
    }
}

