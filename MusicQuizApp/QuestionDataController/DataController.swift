//
//  DataController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 20/12/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import Foundation

// Right now this is a global variable that. These should be avoided.
// An improvement will be to make `QuizData` into a singleton and keep the quiz data in there.
// If you don't need the data to be shared maybe you could ask the `QuizData` to load you a fresh set of questions every time you start.
var sharedQuizData = QuizData.loadInQuizData(forFileNamed: "Noughties")

struct QuizData {
    let questionData: String
    let answersData: [String]
    let correctAnswer: String
    
    static func loadInQuizData(forFileNamed name: String) -> [QuizData] {
        guard let questionsFile = Bundle.main.path(forResource: name, ofType: "plist"),
            let arrayOfQuestions = NSArray(contentsOfFile: (questionsFile)),
            let dictionaryArray = arrayOfQuestions as? [[String: AnyObject]] else {
                return []
        }
        return dictionaryArray.flatMap { dictionary in
            guard let question = dictionary["question"] as? String, let answers = dictionary["answers"] as? [String], let correctAnswer = dictionary["correctAnswer"] as? String else {
                return nil
            }
            return QuizData(questionData: question, answersData: answers, correctAnswer: correctAnswer)
        }
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
