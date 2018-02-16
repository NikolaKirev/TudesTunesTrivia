//
//  UIColor+FontExtentions.swift
//  MusicQuizApp
//
//  Created by John Tudor on 12/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var ttBlueberry: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 57.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
    }
}

// Sample text styles

extension UIFont {
    
    @nonobjc class var ttHeader: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    }
    
    @nonobjc class var ttNormal: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }
}
