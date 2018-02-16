//
//  UIViewPopAnimationExtentions.swift
//  MusicQuizApp
//
//  Created by John Tudor on 14/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /// Briefly "Pops" the imageView, enlarging it's size and then
    /// scaling back down. Useful to show user selection.
    ///
    /// - Parameters:
    ///   - scale: How large the imageView should grow.
    ///   - duration: The duration of the animation.
    func pop(scale: CGFloat = 1.2, duration: TimeInterval = 1) {
        let identity = CGAffineTransform.identity
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.transform = identity.scaledBy(x: scale, y: scale)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = identity
            })
        }, completion: nil)
    }
}
