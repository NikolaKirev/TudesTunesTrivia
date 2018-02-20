//
//  ViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 30/11/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit
import AudioToolbox

class MainQuizController: UIViewController {
    
    @IBOutlet weak var coundownAnimationView: UIView!
    
    @IBOutlet weak var questionsLabel: UILabel! {
        didSet {
            questionsLabel.font = UIFont.systemFont(ofSize: 23.0, weight: .regular)
        }
    }
    
    @IBOutlet var answerButtons: [UIButton]! {
        didSet {
            for button in answerButtons {
                button.layer.cornerRadius = 20
                button.clipsToBounds = true
            }
        }
    }
    
    @IBOutlet weak var nextQuestionButton: UIButton! {
        didSet {
            nextQuestionButton?.backgroundColor = UIColor(red: 255.0 / 255.0, green: 33.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
            nextQuestionButton?.clipsToBounds = true
            nextQuestionButton?.layer.cornerRadius = 5.0
        }
    }
    
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
    
    var countdownLabel = UILabel()
    
    var amountOfCorrectAnswers = 0
    
    var quizData: QuizData!
    
    let shapeLayerDisplay = CAShapeLayer()
    
    let trackLayer = CAShapeLayer()
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    var pulsatingLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImages()
        nextQuestionButton.isHidden = true
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        displayData(question: quizData.questionData, answersData: quizData.answersData)
    }
    
     //MARK: Timer animation
    func createCountdownCircle() {
        
        let position = CGPoint(x: coundownAnimationView.bounds.midX, y: coundownAnimationView.bounds.midY)
        let circularPath = UIBezierPath(arcCenter: position, radius: 50, startAngle: (-.pi / 2), endAngle: CGFloat.pi * 2, clockwise: true)
        
        //PULSE
        pulsatingLayer = CAShapeLayer()
        
        pulsatingLayer.path = circularPath.cgPath
        let pulseColor = UIColor(red: 186.0 / 255.0, green: 219.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        pulsatingLayer.fillColor = pulseColor.cgColor
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.frame = coundownAnimationView.bounds
        coundownAnimationView.layer.addSublayer(pulsatingLayer)

        //TRACK
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.purple.cgColor
        trackLayer.lineWidth = 3
        trackLayer.frame = coundownAnimationView.bounds
        coundownAnimationView.layer.addSublayer(trackLayer)

        //CIRCLE
        shapeLayerDisplay.path = circularPath.cgPath
        shapeLayerDisplay.strokeColor = UIColor.purple.cgColor
        shapeLayerDisplay.strokeEnd = 0
        shapeLayerDisplay.fillColor = UIColor.clear.cgColor
        shapeLayerDisplay.lineCap = kCALineCapRound
        shapeLayerDisplay.lineWidth = 10
        shapeLayerDisplay.frame = coundownAnimationView.bounds
        coundownAnimationView.layer.addSublayer(shapeLayerDisplay)
        
        countdownLabel.frame = coundownAnimationView.bounds
        countdownLabel.textAlignment = .center
        countdownLabel.numberOfLines = 1
        countdownLabel.textColor = UIColor(red: 53.0 / 255.0, green: 57.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
        countdownLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        coundownAnimationView.addSubview(countdownLabel)
    }
    
    //MARK: Timer
    var seconds = 10
    var timer : Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer?.invalidate()
            loadNextSetOfQuestions()
        } else {
            seconds -= 1
            countdownLabel.text = "\(seconds)"
        }
    }
    
    //MARK: Selecting Answer
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        sender.clipsToBounds = true
        sender.layer.cornerRadius = 5.0
        let correctAnswer = quizData.correctAnswer
        amountOfTouches += 1
        pauseTimer()
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
    
    //MARK: Quiz Loaded on VC
    @IBAction func loadNextSetOfQuestions() {
        quizData = sharedQuizData.popLast()
        if quizData == nil {
            loadQuizCompletedView()
        } else {
            guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? MainQuizController else {
                fatalError("no vc to load")
            }
            nextViewController.quizData = quizData
            nextViewController.amountOfCorrectAnswers = amountOfCorrectAnswers
            navigationController?.show(nextViewController, sender: self)
        }
    }
        
    func displayData(question: String, answersData: [String]) {
        runTimer()
        createCountdownCircle()
        animatePulse()
        animateTrack()
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
    
    func setBackgroundImages() {
        let bottom = UIImageView()
        let top = UIImageView()
        let middle = UIImageView()
        addBackgroundImage(backgroundImageView: top, backgroundImage: #imageLiteral(resourceName: "topLeftQuizCircle"), position: CGRect(x: -216, y: -179, width: 431, height: 431))
        addBackgroundImage(backgroundImageView: middle, backgroundImage: #imageLiteral(resourceName: "middleQuizCircle"), position: CGRect(x: 160, y: 252, width: 431, height: 431))
        addBackgroundImage(backgroundImageView: bottom, backgroundImage: #imageLiteral(resourceName: "bottomLeftQuizCircle"), position: CGRect(x: -216, y: 560, width: 431, height: 431))
    }
    
    func addBackgroundImage(backgroundImageView: UIImageView, backgroundImage: UIImage, position: CGRect) {
        backgroundImageView.image = backgroundImage
        backgroundImageView.frame = position
        view.addSubview(backgroundImageView)
    }
    
    //MARK: Private functions
    
    private func animatePulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 0.6
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.isRemovedOnCompletion = false
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    private func animateTrack() {
        basicAnimation.toValue = 1
        basicAnimation.duration = 13.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayerDisplay.add(basicAnimation, forKey: "")
    }
    
    private func pauseTimer() {
        timer = nil
        let pausedTime = shapeLayerDisplay.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayerDisplay.speed = 0.0
        pulsatingLayer.removeFromSuperlayer()
        shapeLayerDisplay.timeOffset = pausedTime
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(MainQuizController.updateTimer)), userInfo: nil, repeats: true)
    }

}
