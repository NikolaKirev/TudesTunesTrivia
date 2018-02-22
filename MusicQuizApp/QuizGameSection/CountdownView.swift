//
//  CountdownView.swift
//  MusicQuizApp
//
//  Created by John Tudor on 22/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate: class {
    func countdownViewDidTimeOut(_ countdownView: CountdownView)
}

class CountdownView: UIView {
    
    private let drawLayer = CAShapeLayer()
    private let pulsatingLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    private let countdownLabel = UILabel()
    
    weak var delegate: CountdownViewDelegate?
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCirclePath(for: pulsatingLayer)
        layoutCirclePath(for: trackLayer)
        layoutCirclePath(for: drawLayer)
    }
    
    // MARK: - Internal methods
    
    func start() {
        runTimer()
        animateCountdown()
    }
    
    func stop() {
        pauseTimer()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        setPulseLayer()
        setTrackLayer()
        setDrawLayer()
        setupCountdownLabel()
    }
    
    //MARK: Timer
    private var seconds = 10
    private var timer : Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }
    
    @objc private func updateTimer() {
        if seconds < 1 {
            timer?.invalidate()
            delegate?.countdownViewDidTimeOut(self)
        } else {
            seconds -= 1
            countdownLabel.text = "\(seconds)"
        }
    }

    
    private func setPulseLayer() {
        let pulseColor = UIColor.ttPowderBlue
        setCountdownProperties(layer: pulsatingLayer, strokeColor: UIColor.clear.cgColor, fillColor: pulseColor.cgColor, lineWidth: 10, framePosition: bounds)
        layer.addSublayer(pulsatingLayer)
    }
    
    private func setTrackLayer() {
        setCountdownProperties(layer: trackLayer, strokeColor: UIColor.purple.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: 3, framePosition: bounds)
        layer.addSublayer(trackLayer)
    }
    
    private func setDrawLayer() {
        setCountdownProperties(layer: drawLayer, strokeColor: UIColor.purple.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: 10, framePosition: bounds)
        drawLayer.strokeEnd = 0
        drawLayer.lineCap = kCALineCapRound
        layer.addSublayer(drawLayer)
    }
    
    private func setupCountdownLabel() {
        countdownLabel.textAlignment = .center
        countdownLabel.numberOfLines = 1
        countdownLabel.textColor = UIColor.ttBlueberry
        countdownLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        addSubview(countdownLabel)
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        countdownLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        countdownLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        countdownLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    private func setCountdownProperties(layer: CAShapeLayer, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat, framePosition: CGRect) {
        layer.strokeColor = strokeColor
        layer.fillColor = fillColor
        layer.lineWidth = lineWidth
        layer.frame = framePosition
    }
    
    private func layoutCirclePath(for layer: CAShapeLayer) {
        let position = CGPoint(x: bounds.midX, y: bounds.midY)
        let circularPath = UIBezierPath(arcCenter: position, radius: 50, startAngle: (-.pi / 2), endAngle: CGFloat.pi * 2, clockwise: true)
        layer.path = circularPath.cgPath
    }
    
    private func animateCountdown() {
        animateTrack()
        animatePulse()
    }
    
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
        drawLayer.add(basicAnimation, forKey: "")
    }
    
    private func pauseTimer() {
        timer = nil
        let pausedTime = drawLayer.convertTime(CACurrentMediaTime(), from: nil)
        drawLayer.speed = 0.0
        pulsatingLayer.removeFromSuperlayer()
        drawLayer.timeOffset = pausedTime
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CountdownView.updateTimer)), userInfo: nil, repeats: true)
    }

    
}
