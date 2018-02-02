//
//  CompletedQuizViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 04/01/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation
import UIKit

class QuizCompletedViewController: UIViewController {
    
    @IBOutlet weak var correctAnswersLabel: UILabel!
    
    override func viewDidLoad() {
        correctAnswersDisplayed()
    }
    
    var correctAnswers: Int = 0
    
    func correctAnswersDisplayed() {
        correctAnswersLabel.text = "Total correct answers: \(correctAnswers)"
    }
    
}

