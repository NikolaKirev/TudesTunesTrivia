//
//  CountingLabel.swift
//  MusicQuizApp
//
//  Created by John Tudor on 20/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation
import UIKit

class CountingLabel: UILabel {
    
    enum AnimationType {
        case Linear
        case EaseIn
        case EaseOut
    }
    
    enum CounterType {
        case Int
        case Float
    }
    
    var startNumber: Float = 0.0
    var endNumber: Float = 0.0
    
    var progress: TimeInterval!
    var duration: TimeInterval!
    
    
    func count(fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, andAnimationType: AnimationType, andCounterType counterType: CounterType) {
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
    }
}
