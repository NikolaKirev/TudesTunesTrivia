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
    }
    
    var correctAnswers: Int = 0

}

enum CountingMethod {
    case easeInOut, easeIn, easeOut, linear
}

enum AnimationDuration {
    case laborious, plodding, strolling, brisk, instant
    
    var value: Double {
        switch self {
        case .laborious: return 20.0
        case .plodding: return 15.0
        case .strolling: return 8.0
        case .brisk: return 2.0
        case .instant: return 0.0
        }
    }
}

typealias OptionalCallback = (() -> Void)
typealias OptionalFormatBlock = (() -> String)

class AnimatedLabel: UILabel {
    var completion: OptionalCallback?
    var animationDuration: AnimationDuration = .brisk
    var countingMethod: CountingMethod = .easeInOut
    var customFormatBlock: OptionalFormatBlock?
    
    fileprivate var currentValue: Float {
        if progress >= totalTime { return destinationValue }
        return startingValue + (update(t: Float(progress / totalTime)) * (destinationValue - startingValue))
    }
    
    fileprivate var rate: Float = 0
    fileprivate var startingValue: Float = 0
    fileprivate var destinationValue: Float = 0
    fileprivate var progress: TimeInterval = 0
    fileprivate var lastUpdate: TimeInterval = 0
    fileprivate var totalTime: TimeInterval = 0
    fileprivate var easingRate: Float = 0
    fileprivate var timer: CADisplayLink?
    
    func count(from: Float, to: Float, duration: TimeInterval? = nil) {
        startingValue = from
        destinationValue = to
        timer?.invalidate()
        timer = nil
        
        if (duration == 0.0) {
            // No animation
            setTextValue(value: to)
            completion?()
            return
        }
        
        easingRate = 3.0
        progress = 0.0
        totalTime = duration ?? animationDuration.value
        lastUpdate = Date.timeIntervalSinceReferenceDate
        rate = 3.0
        
        addDisplayLink()
    }
    
    func countFromZero(to: Float, duration: TimeInterval? = nil) {
        count(from: 0, to: to, duration: duration ?? nil)
    }
    
    fileprivate func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(self.updateValue(timer:)))
        timer?.add(to: .main, forMode: .defaultRunLoopMode)
        timer?.add(to: .main, forMode: .UITrackingRunLoopMode)
    }
    
    fileprivate func update(t: Float) -> Float {
        var t = t
        
        switch countingMethod {
        case .linear:
            return t
        case .easeIn:
            return powf(t, rate)
        case .easeInOut:
            var sign: Float = 1
            if Int(rate) % 2 == 0 { sign = -1 }
            t *= 2
            return t < 1 ? 0.5 * powf(t, rate) : (sign*0.5) * (powf(t-2, rate) + sign*2)
        case .easeOut:
            return 1.0-powf((1.0-t), rate);
        }
    }
    
    @objc fileprivate func updateValue(timer: Timer) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdate
        lastUpdate = now
        
        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }
        
        setTextValue(value: currentValue)
        if progress == totalTime { completion?() }
    }
    
    fileprivate func setTextValue(value: Float) {
        text = String(format: (customFormatBlock?())!, value)
    }
    
}

