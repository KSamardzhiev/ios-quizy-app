//
//  QuestionBrain.swift
//  QuizyApp
//
//  Created by Kostadin Samardzhiev on 23.12.21.
//

import Foundation

struct QuizBrain {
    let quiz = [
        Question(text: "A slug's blood is green.", answer: "True"),
        Question(text: "Approximately one quarter of human bones are in the feet.", answer: "True"),
        Question(text: "The total surface area of two human lungs is approximately 70 square metres.", answer: "True"),
        Question(text: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", answer: "True"),
        Question(text: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", answer: "False"),
        Question(text: "It is illegal to pee in the Ocean in Portugal.", answer: "True"),
        Question(text: "You can lead a cow down stairs but not up stairs.", answer: "False"),
        Question(text: "Google was originally called 'Backrub'.", answer: "True"),
        Question(text: "Buzz Aldrin's mother's maiden name was 'Moon'.", answer: "True"),
        Question(text: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", answer: "False"),
        Question(text: "No piece of square dry paper can be folded in half more than 7 times.", answer: "False"),
        Question(text: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", answer: "True")
    ]
    
    let multiQuiz = [
        QuestionMulti(text: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], answer: "Skin"),
        QuestionMulti(text: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], answer: "100"),
        QuestionMulti(text: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], answer: "Greenwich Mean Time"),
        QuestionMulti(text: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], answer: "Chapeau"),
        QuestionMulti(text: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], answer: "Watch"),
        QuestionMulti(text: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], answer: "Adiós"),
        QuestionMulti(text: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], answer: "Orange"),
        QuestionMulti(text: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], answer: "Rum"),
        QuestionMulti(text: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], answer: "Gorilla"),
        QuestionMulti(text: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], answer: "Australia")
    ]
    
    var questionNumber = 0
    var score = 0
    var isMultiAnswerQuiz = false
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == getQuestionAnswer() {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getQuestionAnswer() -> String{
        if isMultiAnswerQuiz {
            return multiQuiz[questionNumber].answer
        }
        return quiz[questionNumber].answer
    }
    
    func getQuestionText() -> String {
        if isMultiAnswerQuiz {
            return multiQuiz[questionNumber].text
        }
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        return Float(questionNumber + 1) / Float(getCurrentQuizCount())
    }
    
    func getScore() -> Int {
        return score
    }
    
    func isMultiAnswerQuizTypeSelected() -> Bool {
        return isMultiAnswerQuiz
    }
    
    mutating func changeQuizType(_ isMultiAnswer: Bool) {
        isMultiAnswerQuiz = isMultiAnswer
        score = 0
        questionNumber = 0
    }
    
    mutating func nextQuestion() {
        if(questionNumber < getCurrentQuizCount() - 1) {
            questionNumber += 1
        } else {
            questionNumber = 0
            score = 0
        }
    }
    
    func getCurrentQuizCount() -> Int {
        if isMultiAnswerQuiz {
            return multiQuiz.count
        }
        return quiz.count
    }
    
    func getPossibleAnswers() -> [String] {
        return multiQuiz[questionNumber].a
    }
}
