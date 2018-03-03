//
//  ViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 30/11/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit
import AudioToolbox

// cinsider making final
class MainQuizController: UIViewController, CountdownViewDelegate {

    // can these be `private`?
    @IBOutlet weak var coundownAnimationView: CountdownView!
    
    @IBOutlet weak var questionsLabel: QuestionLabel!
    
    @IBOutlet var answerButtons: [AnswerButton]!
    
    @IBOutlet weak var nextQuestionButton: NextQuestionButton!
    
    var amountOfCorrectAnswers = 0
    
    var quizData: QuizData! // This is unsafe. I see you have some logic for checking if this is `nil`. Make it optional.
    
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
            sender.backgroundColor = UIColor.ttWeirdGreen
            nextQuestionButton.isHidden = false
            self.amountOfCorrectAnswers += 1
        } else {
            sender.backgroundColor = UIColor.ttRedOrange
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
    // could be `private`
    func displayData(question: String, answersData: [String]) {
        coundownAnimationView.start()
        questionsLabel.text = question
        let shuffledAnswers = Array(Set(answersData)).shuffled()
        for button in answerButtons {
            button.setTitle(shuffledAnswers[answerButtons.index(of: button)!], for: .normal)
        }
    }

    // could be `private`
    func loadQuizCompletedView() {
        let completedViewController = storyboard?.instantiateViewController(withIdentifier: NewStoryboardIdentifiers.QuizCompleteView.rawValue) as! QuizCompletedViewController // Unsafe. Use `guard` to safely unwrap.
        completedViewController.correctAnswers = self.amountOfCorrectAnswers
        navigationController?.pushViewController(completedViewController, animated: true)
    }
    
    //MARK: Private functions
        
    private func setNavigationProperties() {
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    }
    
}
