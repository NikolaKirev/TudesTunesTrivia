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
    
    var correctAnswers: Int = 0
    
    @IBOutlet weak var correctAnswersLabel: CountingLabel!
    
    @IBOutlet weak var homeButton: HomeButton!
    
    @IBOutlet weak var newCategoryButton: BackToCategoriesButton!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.ttBlueberry
        correctAnswersDisplayed()
    }
    
    func correctAnswersDisplayed() {
        correctAnswersLabel.text = "Total correct answers: \(correctAnswers)"
    }
}
