//
//  ViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 30/11/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerAnimationView: UIImageView!
    let shapeLayerDisplay = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
     //MARK: Timer animation
    func countdownCircle() {
        //TRACK
        let position = timerAnimationView.center
        let circularPath = UIBezierPath(arcCenter: position, radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        view.layer.addSublayer(trackLayer)

        //CIRCLE
        shapeLayerDisplay.path = circularPath.cgPath
        shapeLayerDisplay.strokeColor = UIColor.red.cgColor
        shapeLayerDisplay.strokeEnd = 0
        shapeLayerDisplay.fillColor = UIColor.clear.cgColor
        shapeLayerDisplay.lineCap = kCALineCapRound
        shapeLayerDisplay.lineWidth = 10
        view.layer.addSublayer(shapeLayerDisplay)
    }
    
    func handleTimer() {
        basicAnimation.toValue = 1
        basicAnimation.duration = 11
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayerDisplay.add(basicAnimation, forKey: "")
    }
    
    
    //MARK: Timer
    var seconds = 10
    var timer : Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer?.invalidate()
            loadNextSetOfQuestions()
        } else {
            seconds -= 1
        }
    }
    
    func pauseTimer() {
        timer = nil
        let pausedTime = shapeLayerDisplay.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayerDisplay.speed = 0.0
        shapeLayerDisplay.timeOffset = pausedTime
    }
    
    @IBOutlet weak var questionsLabel: UILabel!
    
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    var amountOfCorrectAnswers = 0
    
    var quizData: QuizData!
    
    var amountOfTouches = 0 {
        didSet {
            if self.amountOfTouches >= 1 {
                answerButtons.forEach({ (button) in
                    button.isEnabled = false
                    button.isUserInteractionEnabled = false
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestionButton.isHidden = true
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        displayData(question: quizData.questionData, answersData: quizData.answersData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Selecting Answer
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let correctAnswer = quizData.correctAnswer
        amountOfTouches += 1
        pauseTimer()
        if sender.title(for: .normal) == correctAnswer {
            sender.backgroundColor = UIColor.green
            nextQuestionButton.isHidden = false
            self.amountOfCorrectAnswers += 1
        } else {
            sender.backgroundColor = UIColor.red
            nextQuestionButton.isHidden = false
        }
    }
    
    //MARK: Quiz Loaded on VC
    @IBAction func loadNextSetOfQuestions() {
        quizData = sharedQuizData.popLast()
        if quizData == nil {
            loadQuizCompletedView()
        } else {
            guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? ViewController else {
                fatalError("no vc to load")
            }
            nextViewController.quizData = quizData
            nextViewController.amountOfCorrectAnswers = amountOfCorrectAnswers
            navigationController?.show(nextViewController, sender: self)
        }
    }
        
    func displayData(question: String, answersData: [String]) {
        runTimer()
        countdownCircle()
        handleTimer()
        questionsLabel.text = question
        let shuffledAnswers = Array(Set(answersData)).shuffled()
        for button in answerButtons {
            button.setTitle(shuffledAnswers[answerButtons.index(of: button)!], for: .normal)
        }
    }
    
    func loadQuizCompletedView() {
        let completedViewController = storyboard?.instantiateViewController(withIdentifier: "QuizCompletedViewController") as! QuizCompletedViewController
        completedViewController.correctAnswers = self.amountOfCorrectAnswers
        navigationController?.pushViewController(completedViewController, animated: true)
    }
}
