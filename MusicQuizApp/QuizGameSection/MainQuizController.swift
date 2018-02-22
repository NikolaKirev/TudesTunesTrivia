//
//  ViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 30/11/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit
import AudioToolbox

class MainQuizController: UIViewController, CountdownViewDelegate {
    
    @IBOutlet weak var coundownAnimationView: CountdownView!
    
    @IBOutlet weak var questionsLabel: UILabel! {
        didSet {
            questionsLabel.font = UIFont.systemFont(ofSize: 23.0, weight: .regular)
        }
    }
    
    @IBOutlet var answerButtons: [AnswerButton]!
    
    @IBOutlet weak var nextQuestionButton: UIButton! {
        didSet {
            nextQuestionButton?.backgroundColor = UIColor(red: 255.0 / 255.0, green: 33.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
            nextQuestionButton?.layer.cornerRadius = (nextQuestionButton?.bounds.size.height)!/2
        }
    }
    
    var amountOfCorrectAnswers = 0
    
    var quizData: QuizData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coundownAnimationView.delegate = self
        nextQuestionButton.isHidden = true
        setNavigationProperties()
        displayData(question: quizData.questionData, answersData: quizData.answersData)
    }
    
     //MARK: CountdownViewDelegate
    
    func countdownViewDidTimeOut(_ countdownView: CountdownView) {
        loadNextSetOfQuestions()
    }
    
    //MARK: Selecting Answer
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let correctAnswer = quizData.correctAnswer
        disableButtons()
        coundownAnimationView.stop()
        if sender.title(for: .normal) == correctAnswer {
            sender.backgroundColor = UIColor.green
            nextQuestionButton.isHidden = false
            self.amountOfCorrectAnswers += 1
        } else {
            sender.backgroundColor = UIColor.red
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            nextQuestionButton.isHidden = false
        }
    }
    
    private func disableButtons() {
        answerButtons.forEach { $0.isUserInteractionEnabled = false }
    }
    
    //MARK: Quiz Loaded on VC
    @IBAction func loadNextSetOfQuestions() {
        quizData = sharedQuizData.popLast()
        if quizData == nil {
            loadQuizCompletedView()
        } else {
            guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: NewStoryboardIdentifiers.NextQuizView.rawValue) as? MainQuizController else {
                fatalError("no vc to load")
            }
            nextViewController.quizData = quizData
            nextViewController.amountOfCorrectAnswers = amountOfCorrectAnswers
            navigationController?.show(nextViewController, sender: self)
        }
    }
        
    func displayData(question: String, answersData: [String]) {
        coundownAnimationView.start()
        questionsLabel.text = question
        let shuffledAnswers = Array(Set(answersData)).shuffled()
        for button in answerButtons {
            button.setTitle(shuffledAnswers[answerButtons.index(of: button)!], for: .normal)
        }
    }
    
    func loadQuizCompletedView() {
        let completedViewController = storyboard?.instantiateViewController(withIdentifier: NewStoryboardIdentifiers.QuizCompleteView.rawValue) as! QuizCompletedViewController
        completedViewController.correctAnswers = self.amountOfCorrectAnswers
        navigationController?.pushViewController(completedViewController, animated: true)
    }
    
    //MARK: Private functions
        
    private func setNavigationProperties() {
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    }
    
}
