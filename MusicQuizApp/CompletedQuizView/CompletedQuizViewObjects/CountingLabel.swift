//
//  CountingLabel.swift
//  MusicQuizApp
//
//  Created by John Tudor on 20/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation // You can remove this. importing UIKit brings Foundation with it.
import UIKit

// TODO: Get this label to actually animate
class CountingLabel: UILabel {

    enum AnimationType {
        case Linear // enumerations should start with a lowercase symbol
        case EaseIn
        case EaseOut
    }
    
    enum CounterType {
        case Int // enumerations should start with a lowercase symbol
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
