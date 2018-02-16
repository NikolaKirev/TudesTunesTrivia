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
    @IBOutlet weak var homeButton: UIButton! {
        didSet {
            homeButton.backgroundColor = UIColor(red: 255.0 / 255.0, green: 33.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
            homeButton?.clipsToBounds = true
            homeButton?.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var newCategoryButton: UIButton! {
        didSet {
            newCategoryButton.backgroundColor = UIColor(red: 255.0 / 255.0, green: 33.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
            newCategoryButton?.clipsToBounds = true
            newCategoryButton?.layer.cornerRadius = 5.0
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 53.0 / 255.0, green: 57.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
        correctAnswersDisplayed()
    }
    
    var correctAnswers: Int = 0
    
    func correctAnswersDisplayed() {
        correctAnswersLabel.text = "Total correct answers: \(correctAnswers)"
    }
    
}

